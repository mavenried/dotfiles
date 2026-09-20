hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "caps:escape",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
            disable_while_typing = false,
        },
    },

    gestures = {
        -- Do not create workspace 4 when swiping past the last existing
        -- workspace. Also do not allow workspace cycling.
        workspace_swipe_create_new = false,
        workspace_swipe_forever = false,
        workspace_swipe_cancel_ratio = 0.5,
        workspace_swipe_distance = 300,
    },
})

-- Niri-style navigation:
--
--   3-finger vertical swipe   -> 1:1 workspace navigation
--   3-finger left/right       -> focus left/right tiled window
--
--   SUPER + 3-finger up/down  -> continuous brightness
--   SUPER + 3-finger left/right -> continuous volume
--
-- The workspace gesture is Hyprland's native 1:1 gesture, so the workspace
-- moves with the fingers and cancels/commits naturally.
hl.gesture({
    fingers = 3,
    direction = "vertical",
    action = "workspace",
})

hl.gesture({
    fingers = 3,
    direction = "left",
    action = function()
        hl.dispatch(hl.dsp.focus({ direction = "l" }))
    end,
})

hl.gesture({
    fingers = 3,
    direction = "right",
    action = function()
        hl.dispatch(hl.dsp.focus({ direction = "r" }))
    end,
})

local function clamp(value)
    return math.max(0.0, math.min(1.0, value))
end

local function read_number(command)
    local pipe = io.popen(command, "r")
    if pipe == nil then
        return 0.5
    end

    local text = pipe:read("*a")
    pipe:close()

    return tonumber(text) or 0.5
end

local function get_brightness()
    local current = read_number("brightnessctl get 2>/dev/null")
    local maximum = read_number("brightnessctl max 2>/dev/null")

    if maximum <= 0 then
        return 0.5
    end

    return clamp(current / maximum)
end

local function get_volume()
    local pipe = io.popen("wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null")
    if pipe == nil then
        return 0.5
    end

    local text = pipe:read("*a")
    pipe:close()

    local value = text:match("Volume:%s*([0-9]*%.?[0-9]+)")
    return clamp(tonumber(value) or 0.5)
end

local function set_qs_brightness(value)
    hl.exec_cmd("qs ipc call osd set_brightness " .. string.format("%.4f", clamp(value)))
end

local function set_qs_volume(value)
    hl.exec_cmd("qs ipc call osd set_volume " .. string.format("%.4f", clamp(value)))
end

-- Live gesture objects use closures for state. Hyprland passes the event
-- directly to start/update/finish; there is no state return value.
local function make_brightness_gesture()
    local start_value = 0.5
    local total = 0.0
    local last_sent = nil

    return {
        start = function(_)
            start_value = get_brightness()
            total = 0.0
            last_sent = start_value
            set_qs_brightness(start_value)
        end,

        update = function(e)
            total = total + e.delta.y

            -- Up is negative Y, so upward movement increases brightness.
            local value = clamp(start_value - total / 500.0)

            if last_sent == nil or math.abs(value - last_sent) >= 0.005 then
                set_qs_brightness(value)
                last_sent = value
            end
        end,

        finish = function(e)
            if not e.cancelled and last_sent ~= nil then
                set_qs_brightness(last_sent)
            end
        end,
    }
end

local function make_volume_gesture()
    local start_value = 0.5
    local total = 0.0
    local last_sent = nil

    return {
        start = function(_)
            start_value = get_volume()
            total = 0.0
            last_sent = start_value
            set_qs_volume(start_value)
        end,

        update = function(e)
            total = total + e.delta.x

            -- Right is positive X, so rightward movement increases volume.
            local value = clamp(start_value + total / 500.0)

            if last_sent == nil or math.abs(value - last_sent) >= 0.005 then
                set_qs_volume(value)
                last_sent = value
            end
        end,

        finish = function(e)
            if not e.cancelled and last_sent ~= nil then
                set_qs_volume(last_sent)
            end
        end,
    }
end

hl.gesture({
    fingers = 3,
    direction = "up",
    mods = "SUPER",
    action = make_brightness_gesture(),
})

hl.gesture({
    fingers = 3,
    direction = "down",
    mods = "SUPER",
    action = make_brightness_gesture(),
})

hl.gesture({
    fingers = 3,
    direction = "left",
    mods = "SUPER",
    action = make_volume_gesture(),
})

hl.gesture({
    fingers = 3,
    direction = "right",
    mods = "SUPER",
    action = make_volume_gesture(),
})
