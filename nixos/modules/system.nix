# Boot, networking, locale, and other host-wide basics.
{ pkgs, ... }:

{
  # This VM boots BIOS/legacy, not UEFI (nixos-generate-config found no
  # EFI system partition — just a bare "/" filesystem), so systemd-boot
  # (which needs an ESP mounted at /boot) is the wrong bootloader here.
  # GRUB installs straight to the disk's MBR instead.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda"; # verify with `lsblk` on the host — virtio disks are usually /dev/vda, adjust if different

  networking.hostName = "mavenried";
  networking.networkmanager.enable = true;

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
    device = "/dev/disk/by-uuid/12373dee-45f9-49ef-80ef-cb2d63d8ff52";
    fsType = "ext4";
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
