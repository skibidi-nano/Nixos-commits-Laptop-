{config, pkgs, lib, ... }: 

{
  home.username = "j";
  home.homeDirectory = "/home/j";
  home.stateVersion = "26.05";

  # Aktiviert und konfiguriert den Zed-Editor direkt im Home Manager
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" ];
    userSettings = {
      theme = {
        mode = "system";
        dark = "One Dark";
        light = "One Light";
      };
      vim_mode = true;
      ui_font_size = 16;
      buffer_font_size = 16;
    };
  };   

  home.packages = with pkgs; [
    firefox
    discord
    spotify
    freecad
    kicad
    keepassxc
    prismlauncher
    r2modman
    kitty
    fastfetch
    tree
    bat
    git
    neovim
    gcc
 ];
}
