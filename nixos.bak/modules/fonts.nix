# Equivalent of mavencore.sh's `getnf -i "JetBrainsMono"` step, done
# declaratively instead of via the getnf script.
{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  fonts.fontconfig.enable = true;
}
