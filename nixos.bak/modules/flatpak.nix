# Flatpak has no clean declarative "install these app IDs" story in
# plain NixOS (that needs the nix-flatpak flake module). Instead this
# mirrors mavencore.sh's idempotent install loop as a script you run
# by hand after `nixos-rebuild switch`, same as you'd rerun the bash
# script before.
{ pkgs, ... }:

{
  services.flatpak.enable = true;

  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "mavencore-flatpak-sync";
      runtimeInputs = [ pkgs.flatpak ];
      text = ''
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

        apps=(
          "com.discordapp.Discord"
          "com.github.johnfactotum.Foliate"
          "com.heroicgameslauncher.hgl"
          "info.febvre.Komikku"
          "io.github.realmazharhussain.GdmSettings"
        )

        for app in "''${apps[@]}"; do
          if flatpak list --app | grep -q "$app"; then
            echo " -> flatpak::$app is already installed"
          else
            echo " -> installing flatpak::$app..."
            flatpak install -y flathub "$app"
          fi
        done
      '';
    })
  ];
}
