hl.on("hyprland.start", function()
    -- hl.exec_cmd() is asynchronous, so the old shell '&' is unnecessary.
    hl.exec_cmd("qs")
    hl.exec_cmd("/mnt/DATA/scripts/wallpaper-init")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("swayosd-server")
end)
