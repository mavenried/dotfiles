local accent = require("hyprland.accent")

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 5,
        border_size = 2,
        col = {
            active_border = accent.hl,
            inactive_border = accent.unfocused_border,
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
        extend_border_grab_area = 2,
    },

    decoration = {
        rounding = 10,
        active_opacity = 1,
        inactive_opacity = 0.9,
        blur = {
            enabled = true,
            size = 1,
            passes = 3,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
        workspace_wraparound = false,
    },

    gestures = {
        workspace_swipe_forever = false,
        workspace_swipe_create_new = false,
    },

    binds = {
        workspace_back_and_forth = false,
        allow_workspace_cycles = false,
    },

    dwindle = {
        preserve_split = true,
    },

})

hl.curve("myBezier", {
    type = "bezier",
    points = {
        { 0.05, 0.9 },
        { 0.1, 1.05 },
    },
})

hl.curve("easeOutBack", {
    type = "bezier",
    points = {
        { 0.175, 0.885 },
        { 0.32, 1.275 },
    },
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 7,
    bezier = "myBezier",
    style = "slide top",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 7,
    bezier = "myBezier",
    style = "slide bottom",
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 7,
    bezier = "default",
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 5,
    bezier = "default",
    style = "slidevert",
})
