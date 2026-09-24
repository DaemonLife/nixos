-- ~/.config/cliamp/plugins/trash.lua
-- x      (cliamp: remove the highlighted track) -> also moves the file to the trash
-- Ctrl+Z (cliamp: undo that removal)            -> also restores the file
-- Plugins can't see the highlighted row, so this watches the playlist instead.
-- Undoing the removal of the track that was playing plays it again: cliamp's
-- Ctrl+Z restores a snapshot whose position points at that track, so playing
-- it keeps the "now playing" mark and actual playback on the same row.
--
-- Needs trash-cli, and in ~/.config/cliamp/config.toml:
--   [plugins]
--   allowed_binaries = "trash-put, mv, rm"

local p = plugin.register({ name = "trash", type = "hook", permissions = { "exec", "control" } })

local TRASH = os.getenv("HOME") .. "/.local/share/Trash"
local prev, last = {}, {}
local trashed = {} -- path -> { name = name in the trash, playing = was it playing }
local pending = {} -- path -> true while trash-put runs, "undo" if Ctrl+Z came meanwhile

local function paths()
    local out = {}
    for i, e in ipairs(cliamp.queue.list()) do out[i] = e.path end
    return out
end

-- If `short` is `long` with exactly one item removed (order kept), return that item.
-- Loading another playlist that happens to be one track shorter doesn't match.
local function removed_one(long, short)
    if #long ~= #short + 1 then return nil end
    local i = 1
    while i <= #short and long[i] == short[i] do i = i + 1 end
    for j = i, #short do if long[j + 1] ~= short[j] then return nil end end
    return long[i]
end

local function contains(list, x)
    for _, v in ipairs(list) do if v == x then return true end end
end

-- First item of `a` that `b` doesn't contain.
local function missing(a, b)
    local set = {}
    for _, x in ipairs(b) do set[x] = true end
    for _, x in ipairs(a) do if not set[x] then return x end end
end

local function infos() return cliamp.fs.listdir(TRASH .. "/info") or {} end
local function base(path) return path:match("[^/]+$") or path end

local restore

local function trash(path, playing)
    local before = infos()
    pending[path] = true
    cliamp.exec.run("trash-put", { "--trash-dir", TRASH, "--", path }, { on_exit = function(code)
        local undo = pending[path] == "undo"
        pending[path] = nil
        if code ~= 0 then return cliamp.message("Trash failed: " .. base(path), 5) end
        -- trash-put renames on collisions: the new .trashinfo gives the real name.
        local name = missing(infos(), before)
        if not name then return cliamp.message("Trashed (can't undo): " .. base(path), 4) end
        trashed[path] = { name = (name:gsub("%.trashinfo$", "")), playing = playing }
        cliamp.message("Trashed (Ctrl+Z restores): " .. base(path), 3)
        if undo then restore(path) end
    end })
end

restore = function(path)
    if pending[path] then pending[path] = "undo"; return end -- still being trashed
    local entry = trashed[path]
    if not entry then return end
    trashed[path] = nil
    local name = entry.name
    if cliamp.fs.exists(path) then return end -- already back, leave the trash alone
    cliamp.exec.run("mv", { "-n", "--", TRASH .. "/files/" .. name, path }, { on_exit = function(code)
        if code ~= 0 or not cliamp.fs.exists(path) then
            return cliamp.message("Restore failed: " .. base(path), 5)
        end
        cliamp.exec.run("rm", { "-f", "--", TRASH .. "/info/" .. name .. ".trashinfo" }, {})
        cliamp.message("Restored: " .. base(path), 3)
        -- It was playing when removed: the restored position points at it, play it.
        if entry.playing then
            for _, e in ipairs(cliamp.queue.list()) do
                if e.path == path then return cliamp.queue.jump(e.index) end
            end
        end
    end })
end

-- Last track that was playing or paused (x on it emits "stopped" afterwards).
p:on("playback.state", function(ev) if ev.status ~= "stopped" then last = ev end end)
p:on("app.start", function() prev = paths() end)

p:on("queue.change", function()
    local now = paths()
    local gone, back = removed_one(prev, now), removed_one(now, prev)
    prev = now

    -- Only a local file that no other row still points to.
    if gone and not contains(now, gone) and cliamp.fs.exists(gone) then
        -- cliamp stops after removing the playing track and leaves the position on
        -- the track that took its place; start it (next() would skip one).
        local playing = gone == last.path and last.status == "playing"
        if playing then
            local i = cliamp.queue.current()
            if i >= 0 and i < #now then cliamp.queue.jump(i) end
        end
        trash(gone, playing)
    elseif back then
        restore(back) -- no-op unless this plugin trashed that path
    end
end)
