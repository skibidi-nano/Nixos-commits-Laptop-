{config, pkgs, lib, ... }: 

{
  home.username = "j";
  home.homeDirectory = "/home/j";
  home.stateVersion = "26.05";

  # wrapperFeatures.gtk = true; # Falls das zu Sway gehört, müsste es inwayland.windowManager.sway stehen!

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false; 
    config = {
      modifier = "Mod4";
      
       
      terminal = "${pkgs.foot}/bin/foot";

      input = {
        "type:keyboard" = {
          xkb_layout = "de";
        }; 
      };

      menu = "${pkgs.wofi}/bin/wofi --show drun";
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+p" = "exec ${config.wayland.windowManager.sway.config.menu}";
        "${modifier}+space" = "exec ${pkgs.rofi}/bin/rofi -show drun";
        "${modifier}+Shift+s" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
      };

      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar"; 
        }
      ];
      output = {
        "*" = {
          bg = "/home/j/Pictures/Wallpapers/a_mountain_range_with_snow.png fill";
        };
      };
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "cpu" "memory" "clock" ];

        "clock" = {
          format = "{:%Y-%m-%d | %H:%M:%S}";
          interval = 1;
        };
      };
    };
  };
}

