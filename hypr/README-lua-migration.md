# Hyprland Lua migration

This archive migrates the supplied Hyprland configuration to the Lua configuration
system introduced in Hyprland 0.55.

Targeted API: Hyprland 0.56.x.

## Install

Copy the contents of this directory into `~/.config/hypr/`.

The active entry point is:

    ~/.config/hypr/hyprland.lua

The old Hyprland configuration is retained under `legacy/` and is not loaded.

The following remain hyprlang configs because they belong to separate Hypr* tools:

- `hypridle.conf`
- `hyprpaper.conf`
- `hyprlock.conf`

No new desktop behavior was added during migration.

## v2 changes

- Removed the `hyprscrolling` dependency from the active configuration.
- Uses Hyprland's native `scrolling` layout.
- Added Niri-style three-finger workspace/window navigation.
- Added SUPER + three-finger brightness/volume controls.
- Existing keyboard brightness/volume OSD bindings are unchanged.

## v4 fix

- Fixed scrolling-layout gesture dispatches: `hl.dsp.layout()` takes a string
  (`"focus l"` / `"focus r"`), not a table.

## v5 gesture behavior

- Workspace wrapping is disabled (`scrolling.wrap_focus = false`).
- 3-finger vertical workspace gestures use Hyprland's native 1:1
  `action = "workspace"` gesture.
- 3-finger horizontal navigation uses a live Lua gesture: the scrolling
  viewport moves with the finger and focus changes on release when the swipe
  crosses the threshold.
- SUPER + 3-finger vertical changes brightness continuously from gesture
  delta using `brightnessctl`.
- SUPER + 3-finger horizontal changes volume continuously from gesture delta
  using `wpctl`.

## v6 changes

- Removed the scrolling layout entirely.
- Uses Hyprland's regular `dwindle` tiling layout.
- Removed all scrolling-layout configuration.
- Three-finger horizontal navigation now focuses the normal left/right tiled window.
- Three-finger vertical navigation remains workspace navigation.
- No workspace wrapping is configured.

## v7 gesture update

- Uses Hyprland's documented live Lua gesture API (`start`, `update`, `finish`).
- 3-finger up/down uses the native 1:1 workspace gesture.
- Workspace swipe creation and wraparound are disabled.
- SUPER + 3-finger brightness/volume gestures continuously update the QS OSD
  through `osd set_brightness(float)` and `osd set_volume(float)`.
- Brightness/volume starting values are read only at gesture start; all writes
  go through QS IPC.

## v8 fixes

- Fixed live gesture callbacks to use Hyprland's documented event argument.
- Removed the invalid returned-state assumption that caused `nil` errors.
- Workspace navigation now uses one native vertical 1:1 gesture.
- Disabled creation of new workspaces from the swipe gesture.
- Disabled workspace cycling/wraparound.
- Kept SUPER brightness/volume gestures live and QS-backed.
