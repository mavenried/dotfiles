{ pkgs, lib, config, ... }:

let
  greeterFolder = /. + "/mnt/DATA/.config/quickshell/greeter";
  myQmlFile = "${greeterFolder}/shell.qml";

  niriGreeterConfig = pkgs.writeText "niri-greeter-config.kdl" ''
    input {}
    hotkey-overlay { skip-at-startup; }
    
    // Executes quickshell, and forces Niri to instantly quit skipping confirmations when quickshell exits
    spawn-at-startup "sh" "-c" "${pkgs.quickshell}/bin/quickshell -p ${myQmlFile} && ${pkgs.niri}/bin/niri msg action quit --skip-confirmation"
  '';

  nixosSessionsDir = "${config.services.displayManager.sessionData.desktops}/share";
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.bash}/bin/bash -c 'export XDG_DATA_DIRS=${nixosSessionsDir}:${pkgs.quickshell}/share:/usr/share; export SESSION_DIRS=${nixosSessionsDir}/wayland-sessions:${nixosSessionsDir}/xsessions; ${pkgs.niri}/bin/niri -c ${niriGreeterConfig}'";
        user = "greeter";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "L+ /usr/share/wayland-sessions - - - - ${nixosSessionsDir}/wayland-sessions"
    "L+ /usr/share/xsessions - - - - ${nixosSessionsDir}/xsessions"
  ];

  environment.etc."greetd".source = greeterFolder;

  environment.systemPackages = [
    pkgs.niri
    pkgs.quickshell
  ];

  users.extraUsers.greeter.extraGroups = [ "video" "input" ];

  systemd.services.greetd.serviceConfig = {
    KillMode = lib.mkForce "control-group";
  };
}

