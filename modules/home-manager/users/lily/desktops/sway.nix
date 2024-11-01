{
  lib,
  config,
  pkgs,
  ...
}: {
  home-manager.users.lily = lib.mkIf (config.queernix.users.lily.enable && config.queernix.desktops.sway.enable) {
    home.packages = with pkgs; [ playerctl ];

    stylix.targets = {
      sway.enable = true;
      tofi.enable = true;
      dunst.enable = true;
    };
  
    programs.tofi = {
      enable = true;
      settings = {
        width = "100%";
        height = "100%";
        border-width = 0;
        outline-width = 0;
        padding-left = "35%";
        padding-top = "35%";
        result-spacing = 25;
        num-results = 5;
        font = "Ubuntu Sans Mono";
        background-color = lib.mkForce "#000A";
        history = true;
        fuzzy-match = true;
        drun-launch = true;
      };
    };

    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = "sway-session.target";
      };
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          # output = [ "DP-1" ];
          modules-left = ["sway/workspaces" "privacy"];
          modules-center = ["clock"];
          modules-right = ["tray" "wireplumber"];

          "clock" = {
            timezone = "America/New_York";
            locale = "de_AT.UTF-8";
            format = "{:%H:%M | %d/%m/%Y}";
            tooltip = false;
          };
        };
      };

      style = (builtins.readFile ./assets/waybar.css);
    };

    services.dunst = {
      enable = true;
      configFile = ./assets/dunstrc;
    };

    services.playerctld.enable = true;

    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.swayfx;
      checkConfig = false; # until https://github.com/nix-community/home-manager/issues/5379
      wrapperFeatures.gtk = true;
      systemd.enable = true;
      config = rec {
        modifier = "Mod4";
        terminal = "kitty";
        gaps = {
          outer = 0;
          inner = 3;
        };
        bars = [];

        keybindings = lib.mkOptionDefault {
          "${modifier}+Shift+s" = "exec ${pkgs.grimblast}/bin/grimblast copy area";
          "${modifier}+d" = "exec ${pkgs.tofi}/bin/tofi-drun";

          "XF86AudioRaiseVolume" = "exec pamixer --increase 5";
          "XF86AudioLowerVolume" = "exec pamixer --decrease 5";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioPause" = "exec playerctl pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";
        };

        output = {
          "DP-1" = {
            mode = "3840x2160@240Hz";
            scale = "1.5";
          };
          "DP-2" = {
            mode = "1920x1080@164.917Hz";
            scale = "1";
          };
        };
      };

      extraConfig = ''
        blur true
        blur_xray false
        blur_passes 3
        blur_radius 8
        blur_noise 0.01
        blur_brightness 1
        blur_contrast 1

        shadows true
        shadow_blur_radius 30
        shadow_color #00000070
        shadow_inactive_color #00000010

        default_dim_inactive 0.25

        default_border pixel 1
        corner_radius 10

        layer_effects "waybar" blur enable; shadows enable; corner_radius 0;
      '';
    };

    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      "_JAVA_AWT_WM_NONREPARENTING" = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      GDK_BACKEND = "wayland";
      XDG_SESSION_DESKTOP = "sway";
      MOZ_ENABLE_WAYLAND = "1";
      GDK_DPI_SCALE = "1.5";
    };

    home.file.".config/sway/bg.jpg" = {
      source = ./assets/wallpaper.jpg;
    };
  };
}
