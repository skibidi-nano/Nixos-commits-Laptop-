{config, pkgs, lib, ... }: # 'lib' hinzugefügt, da du es unten benutzt!

{
  home.username = "j";
  home.homeDirectory = "/home/j";
  home.stateVersion = "26.05";

  # wrapperFeatures.gtk = true; # Falls das zu Sway gehört, müsste es inwayland.windowManager.sway stehen!

  wayland.windowManager.sway = {
    enable = true; # Falls du Sway nutzt, muss das hier drumherum
    config = {
      modifier = "Mod4"; # Korrigiert von 'modifer' zu 'modifier'
      terminal = "${pkgs.foot}/bin/foot";

      input = {
        "type:keyboard" = {
          xkb_layout = "de";
        }; # Hier fehlte das Schließen des Keyboards!
      };

      # wofi hier bro
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+p" = "exec ${config.wayland.windowManager.sway.config.menu}";
      };

      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar"; # Hier fehlte das Semikolon!
        }
      ];
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

