{ lib, pkgs, pkgs-unstable, catppuccin, ... }:

{
  imports = [
    ./lily/nix-index.nix
    ./lily/direnv.nix
    ./lily/git.nix
    ./lily/term.nix
    # ./lily/sway.nix
    ./lily/helix.nix
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
    packages = (with pkgs-unstable; [
      # vesktop until https://github.com/NixOS/nixpkgs/issues/340196 is solved somehow
    ]) ++ (with pkgs; [
      firefox-devedition-bin
      vesktop
    ]);

    pointerCursor = {
      size = 32;
      x11.enable = true;
      gtk.enable = true;
    };

    stateVersion = "24.05";
  };

  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      gnomeShellTheme = true;
      icon.enable = true;
    };
  };
}
