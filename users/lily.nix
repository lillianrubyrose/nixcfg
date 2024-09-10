{ pkgs, pkgs-unstable, ... }:

{
  home = {
    username = "lily";
    homeDirectory = "/home/lily";
    packages = with pkgs; [
      firefox
      btop
      unzip
    ];
  };
}
