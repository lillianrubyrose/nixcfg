{
  lib,
  config,
  catppuccin,
  pkgs,
  ...
}: {
  home-manager = lib.mkIf config.queernix.users.lily.enable {
    extraSpecialArgs = {
      inherit catppuccin;
    };

    users.lily = {
      imports = [
        catppuccin.homeManagerModules.catppuccin
      ];

      catppuccin = {
        # flavor = "latte";
        flavor = "mocha";
        accent = "lavender";

        pointerCursor = {
          enable = true;
          accent = "dark";
        };
      };

      home = {
        username = "lily";
        homeDirectory = lib.mkDefault "/home/lily";
        packages = with pkgs; [
          firefox-devedition-bin
          vesktop
        ];

        pointerCursor = {
          size = 32;
          x11.enable = true;
          gtk.enable = true;
        };

        stateVersion = "24.05";
      };

      services.gpg-agent = {
        enable = true;
        enableFishIntegration = true;
        enableSshSupport = true;
        enableScDaemon = true;
        sshKeys = ["5D8B8D8A957EDA5C4784CDE7525C508B506BF655"];
      };

      qt.style.catppuccin.enable = true;
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
