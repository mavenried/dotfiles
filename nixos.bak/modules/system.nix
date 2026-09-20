# Boot, networking, locale, and other host-wide basics.
{ pkgs, ... }:

{
  networking.hostName = "mavenried";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  nixpkgs.config.allowUnfree = true;

  fileSystems."/mnt/DATA" = {
    device = "/dev/disk/by-uuid/6ab6063f-83fc-4952-bcff-544b5175bf9b";
    fsType = "ext4";
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
