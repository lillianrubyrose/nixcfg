{ lib, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./lily/nix-index.nix
    ./lily/direnv.nix
    ./lily/git.nix
    ./lily/term.nix
    ./lily/sway.nix
    # ./lily/hyprland.nix
  ];

  home = {
    username = "lily";
    homeDirectory = lib.mkDefault "/home/lily";
    packages = (with pkgs-unstable; [
      # vesktop until https://github.com/NixOS/nixpkgs/issues/340196 is solved somehow
    ]) ++ (with pkgs; [
      firefox-devedition-bin
      vesktop
    ]);

    stateVersion = "24.05";
  };
}
