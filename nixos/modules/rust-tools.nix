# Your personal cargo tools (colorctl, dvault, etc.) aren't in
# nixpkgs, so cargo install is still the right tool for them. This is
# the same idempotent loop mavencore.sh ran, exposed as a command
# instead of a one-off script. Requires cargo/rustup to already be on
# PATH (rustup is in packages.nix).
{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "mavencore-rust-sync";
      text = ''
        packages=(
          "colorctl"
          "dvault"
          "lsr-nf"
          "musicman"
          "proj-cmd"
          "slint-lsp"
          "kdlfmt"
        )

        for package in "''${packages[@]}"; do
          if command -v "$package" &>/dev/null; then
            echo " -> cargo::$package is already installed"
          else
            echo " -> installing cargo::$package..."
            cargo install "$package"
          fi
        done
      '';
    })
  ];
}
