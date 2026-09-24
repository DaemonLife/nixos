-- ~/.config/cliamp/plugins/trash.lua
--
-- x      (cliamp: remove the highlighted track from the playlist)
--        -> also moves that file to ~/.local/share/Trash
-- Ctrl+Z (cliamp: undo the last playlist removal)
--        -> also restores the file from the trash
--
-- Plugins can't read the highlighted row or bind Ctrl+Z, so instead this
-- watches the playlist: exactly one local file gone = trash it, the same
-- file back = restore it.
--
-- Needs trash-cli, and in ~/.config/cliamp/config.toml:
--   [plugins]
--   allowed_binaries = "trash-put, mv"

local p = plugin.register({
    name        = "trash",
    type        = "hook",
    permissions = { "exec" },
})

-- Explicit dir: exec'd processes don't inherit $XDG_DATA_HOME, and this also
-- keeps files from other partitions going to the home trash.
local TRASH = os.getenv("HOME") .. "/.local/share/Trash"

local prev    = {} -- playlist paths as of the last queue.change
local trashed = {} -- stack of { path, name } for files this plugin trashed
local pending = {} -- path -> true while trash-put runs, "undo" if Ctrl+Z came meanwhile

local function paths()
    local out = {}
    for i, e in ipairs(cliamp.queue.list()) do out[i] = e.path end
    return out
end

-- If `long` is `short` with exactly one element inserted, return that element.
local function one_extra(long, short)
    if #long ~= #short + 1 then return nil end
    local i = 1
    while i <= #short and long[i] == short[i] do i = i + 1 end
    for j = i, #short do
        if long[j + 1] ~= short[j] then return nil end
    end
    return long[i]
end

local function contains(list, value)
    for _, v in ipairs(list) do
        if v == value then return true end
    end
    return false
end

local function basename(path)
    return path:match("[^/]+$") or path
end

-- Original location recorded in a .trashinfo file (percent-encoded per the spec).
local function original_path(info_file)
    local text = cliamp.fs.read(TRASH .. "/info/" .. info_file) or ""
    local enc = text:match("\nPath=([^\n]*)") or text:match("^Path=([^\n]*)")
    if not enc then return nil end
    return (enc:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end))
end

local function info_files()
    local set = {}
    for _, name in ipairs(cliamp.fs.listdir(TRASH .. "/info") or {}) do set[name] = true end
    return set
end

local restore -- defined below, used by trash() for a Ctrl+Z that came too early

local function trash(path)
    pending[path] = true
    local before = info_files()
    cliamp.exec.run("trash-put", { "--trash-dir", TRASH, "--", path }, {
        on_exit = function(code)
            local undo = pending[path] == "undo"
            pending[path] = nil
            if code ~= 0 then
                cliamp.message("Trash failed (code " .. code .. ")", 5)
                return
            end
            -- trash-put renames on name collisions, so find the .trashinfo it just made.
            for file in pairs(info_files()) do
                if not before[file] and original_path(file) == path then
                    table.insert(trashed, { path = path, name = (file:gsub("%.trashinfo$", "")) })
                    break
                end
            end
            cliamp.message("Trashed: " .. basename(path) .. "  (Ctrl+Z restores)", 4)
            if undo then restore(path) end
        end,
        timeout = 120, -- a move to another partition is a real copy
    })
end

restore = function(path)
    if pending[path] then pending[path] = "undo"; return end -- finish trashing first
    for i = #trashed, 1, -1 do
        local t = trashed[i]
        if t.path == path then
            table.remove(trashed, i)
            if cliamp.fs.exists(path) then return end
            cliamp.exec.run("mv", { "-n", "--", TRASH .. "/files/" .. t.name, path }, {
                on_exit = function(code)
                    if code ~= 0 or not cliamp.fs.exists(path) then
                        cliamp.message("Restore failed: " .. basename(path), 5)
                        return
                    end
                    -- Drop the .trashinfo too. Plugins may only delete under /tmp,
                    -- so move it there first.
                    local tmp = "/tmp/cliamp-restored-" .. t.name .. ".trashinfo"
                    cliamp.exec.run("mv", { "--", TRASH .. "/info/" .. t.name .. ".trashinfo", tmp }, {
                        on_exit = function() cliamp.fs.remove(tmp) end,
                    })
                    cliamp.message("Restored: " .. basename(path), 3)
                end,
                timeout = 120,
            })
            return
        end
    end
end

p:on("app.start", function() prev = paths() end)

p:on("queue.change", function()
    local now = paths()
    local gone = one_extra(prev, now) -- one entry removed (x)
    local back = one_extra(now, prev) -- one entry added (Ctrl+Z, or adding a file)
    prev = now

    -- Only a local file that no other playlist row still points to.
    if gone and not contains(now, gone) and cliamp.fs.exists(gone) then
        trash(gone)
    elseif back then
        restore(back) -- no-op unless this plugin trashed that path
    end
end)
