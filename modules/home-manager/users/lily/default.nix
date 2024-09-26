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
        flavor = "latte";
        # flavor = "mocha";
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

          # fonts
          victor-mono # programming
          ubuntu-sans # for system use (kde, waybar, etc)
          ubuntu-sans-mono # for system use (kde, waybar, etc)
        ];

        pointerCursor = {
          size = 32;
          x11.enable = true;
          gtk.enable = true;
        };

        stateVersion = "24.05";
      };

      programs.ncspot.enable = true;
      qt.style.catppuccin.enable = true;
      fonts.fontconfig.enable = true;
    };
  };
}
