{
  lib,
  pkgs,
  catppuccin,
  hostname,
  ...
}: {
  home-manager.extraSpecialArgs = {
    inherit catppuccin;
  };

  home-manager.users.lily = {
    imports =
      [
        ./common
        catppuccin.homeManagerModules.catppuccin
      ]
      ++ (
        if hostname == "nya"
        then [
          ./dev
        ]
        else []
      );

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
        serious-sans
      ];

      pointerCursor = {
        size = 32;
        x11.enable = true;
        gtk.enable = true;
      };

      stateVersion = "24.05";
    };

    qt.style.catppuccin.enable = true;
    fonts.fontconfig.enable = true;
  };
}
