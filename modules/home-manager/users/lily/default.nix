{
  lib,
  config,
  pkgs,
  stylix,
  ...
}: {
  home-manager = lib.mkIf config.queernix.users.lily.enable {
    extraSpecialArgs = {
      inherit stylix;
    };

    users.lily = {
      imports = [
        stylix.homeManagerModules.stylix
      ];

      stylix = {
        enable = true;
        autoEnable = false;
        image = ./desktops/assets/wallpaper.jpg;
        imageScalingMode = "fill";

        fonts = rec {
          sansSerif = {
            package = pkgs.ubuntu-sans;
            name = "Ubuntu Sans";
          };
        
          monospace = {
            package = pkgs.ubuntu-sans-mono;
            name = "Ubuntu Sans Mono";
          };

          emoji = {
            package = pkgs.noto-fonts-emoji;
            name = "Noto Color Emoji";
          };

          serif = sansSerif;
        };

        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";

        cursor = {
          package = pkgs.catppuccin-cursors.latteLight;
          name = "catpuccin-cursors-latteLight";
        };

        targets = {
          gtk.enable = true;
          gnome.enable = true;
        };
      };

      home = {
        username = "lily";
        homeDirectory = lib.mkDefault "/home/lily";
        packages = with pkgs; [
          firefox-devedition-bin
          vesktop
        ];

        stateVersion = "24.05";
      };

      services.gpg-agent = {
        enable = true;
        enableFishIntegration = true;
        enableSshSupport = true;
        enableScDaemon = true;
        sshKeys = ["5D8B8D8A957EDA5C4784CDE7525C508B506BF655"];
      };

      fonts.fontconfig.enable = true;

      # TODO: Make apart of pipewire setting
      services.easyeffects = {
        enable = true;
      };

      # TODO: make its own module and setting
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs # potentially better support when using wlroots compositors?
          obs-backgroundremoval # for webcam
          obs-pipewire-audio-capture # i think this is for per-application audio capture which fucks
          obs-tuna # song information
          input-overlay
          obs-composite-blur # blur plugin
          obs-vaapi
        ];
      };
    };
  };
}
