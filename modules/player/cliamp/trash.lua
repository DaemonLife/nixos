-- ~/.config/cliamp/plugins/trash.lua
-- Alt+D: move the playing track to ~/.local/share/Trash and play the next one.
-- Needs trash-cli, plus in ~/.config/cliamp/config.toml:
--   [plugins]
--   allowed_binaries = "trash-put"

local p = plugin.register({
  name = "trash",
  type = "hook",
  permissions = { "keymap", "exec", "control" },
})

-- Explicit dir: exec'd processes don't inherit $XDG_DATA_HOME, and this also
-- keeps files from other partitions going to the home trash.
local TRASH = os.getenv("HOME") .. "/.local/share/Trash"

-- Status-bar confirmation. Shown with a short delay so it lands after the
-- track switch; otherwise the new track's own status replaces it instantly.
local function notify(path)
  cliamp.timer.after(0.5, function()
    cliamp.message("Trashed: " .. path:match("[^/]+$"), 4)
  end)
end

-- Remove every playlist row for `path` (bottom-up so indices don't shift).
-- If `realign` is set, re-jump to the playing track afterwards: removing a
-- row above the cursor doesn't move the cursor up, and jump() is the only
-- plugin call that sets it. The restart happens a split second into the
-- track, so it's inaudible.
local function drop(path, realign)
  local cur, target = cliamp.queue.current(), cliamp.queue.current()
  local list = cliamp.queue.list()
  for i = #list, 1, -1 do
    if list[i].path == path then
      if list[i].index < cur then
        target = target - 1
      end
      cliamp.queue.remove(list[i].index)
    end
  end
  if not realign then
    return
  end
  if cliamp.track.path() == path then
    cliamp.player.stop() -- no next track (end of list / repeat one)
  else
    cliamp.queue.jump(target)
  end
  notify(path)
end

-- next() is applied asynchronously, so poll (max ~2s) until the playing
-- track actually changes before touching the playlist. Letting the player
-- pick the next track keeps shuffle, repeat and the play-next queue native.
local function wait_and_drop(path, tries)
  if cliamp.track.path() ~= path or tries == 0 then
    drop(path, true)
  else
    cliamp.timer.after(0.05, function()
      wait_and_drop(path, tries - 1)
    end)
  end
end

p:bind("alt+d", "Move track to trash", function()
  local path = cliamp.track.path()
  if cliamp.track.is_stream() or path == "" then
    return
  end

  cliamp.exec.run("trash-put", { "--trash-dir", TRASH, "--", path }, {
    on_exit = function(code)
      if code ~= 0 then
        cliamp.message("Trash failed (code " .. code .. ")", 5)
        return
      end
      if cliamp.track.path() == path then
        cliamp.player.next()
        wait_and_drop(path, 40)
      else
        drop(path, false) -- user already switched tracks by hand
        notify(path)
      end
    end,
  })
end)
