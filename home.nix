{ config, pkgs, inputs, ... }: 

{
  imports = [
    inputs.noctalia.homeModules.default # Pulls in the Noctalia Home Manager module
  ];

  home.username = "j";
  home.homeDirectory = "/home/j";
  home.stateVersion = "26.05";

  programs.git = {
    enable = true;
    userName = "skibidi-nano";
    userEmail = "nanulianhkr@gmail.com";
  };

  # Cleaned up interactive shell helper (moved out of system configuration)
  programs.bash = {
    enable = true;
    initExtra = ''
      nix-switch() {
        cd ~/cocktop && \
        git add . && \
        sudo nixos-rebuild switch --impure --flake . && \
        git commit -m "Update: $(date +'%Y-%m-%d %H:%M:%S')" && \
        git push skibidi-nano main
      }
    '';
  };

  # Enable and configure Noctalia Shell via Home Manager
  programs.noctalia = {
    enable = true;
    # settings = {
    #   # Add custom Noctalia configurations here if needed
    # };
  };

  # Hyprland Window Manager & Autostart
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "noctalia"
      ];
      layerrule = [
        "blur, noctalia"
        "ignorezero, noctalia"
      ];

      # Super-Taste (Windows-Taste) definieren
      "$mod" = "SUPER";

      # Tastenkombinationen
      bind = [
        "$mod, Q, exec, kitty"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, R, exec, rofi -show drun"
        "$mod, E, exec, dolphin"
        "$mod, V, togglefloating,"
        
        # Fokus wechseln (Vim keybindings)
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
      ];

      # Fenster mit der Maus verschieben / skalieren
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };

  # VS Code Configuration
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
        "editor.inlineSuggest.enabled" = false;
        "editor.quickSuggestions" = { "other" = "off"; "comments" = "off"; "strings" = "off"; };
      };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.file.".wakatime.cfg".text = ''
    [settings]
    api_url = https://hackatime.hackclub.com/api/hackatime/v1
    api_key = 0dc2b09c-4551-4ebb-92c3-19756595279a
    heartbeat_rate_limit_seconds = 30
    debug = true
    hide_filenames = false
    hide_branch_names = false
  '';

  # User Packages including Hyprland ecosystem components
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
    
    # Wayland / Hyprland essentials
    waybar
    rofi
    mako
    wl-clipboard
    inputs.noctalia.packages.${pkgs.system}.default

    # Fonts & Icons for Noctalia styling
    nerd-fonts.jetbrains-mono
    papirus-icon-theme
    qt6.qtwayland
    kdePackages.qtsvg
  ];
}
