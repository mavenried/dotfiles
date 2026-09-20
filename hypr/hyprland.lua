-- Hyprland Lua configuration
-- Migrated from the supplied hyprlang configuration.
-- Target: Hyprland 0.56.x
--
-- Hyprland 0.55+ uses Lua for its native configuration.
-- The old configuration is retained under ./legacy/ for rollback/reference.

local programs = require("hyprland.programs")
local accent = require("hyprland.accent")

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

require("hyprland.env")
require("hyprland.layout")
require("hyprland.input")
require("hyprland.binds")
require("hyprland.misc")
require("hyprland.cursor")
require("hyprland.startup")
