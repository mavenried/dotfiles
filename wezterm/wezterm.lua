local wezterm = require("wezterm")
local config = {}

-- Use the newer configuration builder for better error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Color scheme
config.color_scheme = "Catppuccin Mocha"

-- Font
config.font = wezterm.font_with_fallback({
	"JetBrains Mono Nerd Font",
	"Fira Code",
	"Iosevka",
})
config.font_size = 16.0
config.harfbuzz_features = { "calt", "clig", "liga" } -- enable ligatures

-- Window & UI
config.enable_tab_bar = false

config.window_decorations = "NONE"
config.window_background_opacity = 0.92
config.macos_window_background_blur = 20
config.initial_rows = nil
config.initial_cols = nil

-- Behavior
config.automatically_reload_config = true
config.use_ime = false
config.scrollback_lines = 5000

-- Performance tweaks
config.front_end = "WebGpu"
config.enable_wayland = true

-- Keybindings (optional)
config.keys = {
	{ key = "r", mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration },
}

return config
