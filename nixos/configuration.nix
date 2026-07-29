# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
#
# This file just wires up the hardware scan plus the topic modules
# below; the actual config lives in ./modules/.

{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system.nix
    ./modules/desktop.nix
    ./modules/users.nix
    ./modules/packages.nix
    ./modules/fonts.nix
    ./modules/flatpak.nix
    ./modules/rust-tools.nix
  ];
}
