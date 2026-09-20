local programs = require("hyprland.programs")

local mainMod = "SUPER"

-- Applications / session
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("systemctl suspend"))
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.exec_cmd("poweroff"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("/mnt/DATA/scripts/restart qs"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(programs.browser1))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(programs.browser2))

hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("qs ipc call lockscreen lock"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("qs ipc call wallpaper reload"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(programs.menu))

-- Bluetooth devices
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("bluetoothctl connect 3E:99:E7:FA:11:97"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("bluetoothctl disconnect 3E:99:E7:FA:11:97"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("bluetoothctl connect 41:42:02:0F:09:DB"))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.exec_cmd("bluetoothctl disconnect 41:42:02:0F:09:DB"))

-- Function keys
hl.bind("Print", hl.dsp.exec_cmd("grim"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("qs ipc call osd volume_up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("qs ipc call osd volume_down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("qs ipc call osd volume_mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("qs ipc call osd brightness_up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("qs ipc call osd brightness_down"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("/mnt/DATA/scripts/player-control toggle"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("/mnt/DATA/scripts/player-control toggle"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("/mnt/DATA/scripts/player-control next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("/mnt/DATA/scripts/player-control prev"))

-- Directional focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workspaces 1-10.
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("moosic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:moosic" }))

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move / resize windows
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
