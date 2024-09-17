{
  lib,
  pkgs,
  pkgs-unstable,
  catppuccin,
  ...
}:

{
  imports = [
    ./lily/nix-index.nix
    ./lily/direnv.nix
    ./lily/git.nix
    ./lily/term.nix
    ./lily/helix.nix
    ./lily/plasma.nix
    ./lily/vscode.nix
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
}
