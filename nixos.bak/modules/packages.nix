# System package set. Mirrors the package list from mavencore.sh
# (the Arch/AUR bootstrap script for this host), translated to nixpkgs
# attribute names. Anything with no nixpkgs equivalent is left
# commented out with a note on where it actually comes from.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neovim
    bat
    brightnessctl
    clang
    cloudflared
    cmake
    dysk
    eza
    fzf
    gcc
    ghostty
    git
    gh # github-cli
    gum
    helix
    hypridle
    hyprlock
    hyprpaper
    jdk # jdk-openjdk
    kitty
    libqalculate
    macchina
    mpvpaper
    nautilus
    nodejs # includes npm
    pamixer
    papers
    pavucontrol
    perl
    polkit_gnome
    quickshell
    rsync
    rustup
    sshpass
    starship
    trash-cli
    unzip
    waybar
    wine
    wl-clipboard
    xwayland-satellite
    zed-editor # zed
    zellij
    zip
    zoxide
    zsh-completions # autosuggestions/syntax-highlighting are handled by programs.zsh

    # LSPs
    bash-language-server
    taplo
    vscode-langservers-extracted # provides the jsonls used by vscode-json-languageserver
    # ty                        # verify this exists on your nixpkgs channel before enabling
    # hyprls                    # was AUR "hyprls-git"; verify current nixpkgs attr name

    # No nixpkgs package — install manually / via their own flake if needed:
    # - freedownloadmanager (AUR-only proprietary binary)
    # - zen-browser (ships its own flake, not in nixpkgs)
  ];
}
