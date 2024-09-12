{ lib, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./lily/nix-index.nix
    ./lily/direnv.nix
    ./lily/git.nix
    ./lily/term.nix
  ];

  home = {
    username = "lily";
    homeDirectory = lib.mkDefault "/home/lily";
    packages = (with pkgs-unstable; [
      vesktop
    ]) ++ (with pkgs; [
      firefox-devedition-bin
    ]);

    stateVersion = "24.05";
  };
}
