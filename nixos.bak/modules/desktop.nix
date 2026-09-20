# Display server, session compositors, audio, and printing.
{ pkgs, ... }:

{
  # tuigreet needs no compositor of its own — it discovers the
  # Hyprland/niri session entries installed by programs.hyprland and
  # programs.niri and lets you pick one. Swap this for a quickshell
  # greeter later (quickshell itself is in packages.nix now — what's
  # still missing is a hand-written greetd-ipc greeter UI in QML).
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --asterisks";
      user = "greeter";
    };
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.hyprland.enable = true;
  # Niri module (nixpkgs >= 24.11 unstable). If this attribute doesn't
  # exist on your channel, drop it and add `pkgs.niri` to packages.nix
  # instead.
  programs.niri.enable = true;

  # polkit_gnome is only a package here (see packages.nix) — your
  # hyprland/niri startup configs already `exec-once` the agent.
  security.polkit.enable = true;
}
