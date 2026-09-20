# User account and default shell/browser.
{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  users.users.maverikio = {
    isNormalUser = true;
    description = "Joseph Chacko";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  programs.firefox.enable = true;
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };
}
