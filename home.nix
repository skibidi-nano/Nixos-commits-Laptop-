{config, pkgs, lib, ... }: 

{
  home.username = "j";
  home.homeDirectory = "/home/j";
  home.stateVersion = "26.05";

  programs.git = {
    enable = true;
    userName = "skibidi-nano";
    userEmail = "nanulianhkr@gmail.com";
  };

  # VS Code Konfiguration (Haupteditor)
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        wakatime.vscode-wakatime
        jnoortheen.nix-ide
        mkhl.direnv
      ];
      userSettings = {
        "wakatime.cliPath" = "${pkgs.wakatime-cli}/bin/wakatime-cli";
        "workbench.colorTheme" = "Solarized Light";

        # Inline Suggestions / Autocomplete deaktivieren
        "editor.inlineSuggest.enabled" = false;
        "editor.quickSuggestions" = {
          "other" = "off";
          "comments" = "off";
          "strings" = "off";
        };
      };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };


  # WakaTime / Hackatime Konfiguration
  home.file.".wakatime.cfg".text = ''
    [settings]
    api_url = https://hackatime.hackclub.com/api/hackatime/v1
    api_key = 0dc2b09c-4551-4ebb-92c3-19756595279a
    heartbeat_rate_limit_seconds = 30
    debug = true
    hide_filenames = false
    hide_branch_names = false
  '';
 

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
    slack
 ];
}
