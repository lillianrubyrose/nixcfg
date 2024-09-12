{ lib, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./common/nix.nix
    ./common/i18n.nix
    ./common/pipewire.nix
  ];

  networking.networkmanager.enable = true;

  environment = {
    systemPackages = (with pkgs-unstable; [
      helix # terminal editor of choice
    ]) ++ (with pkgs; [
      wget
    ]);

    sessionVariables = {
      EDITOR = "hx";
    };
  };

  programs = {
    git.enable = true;
  };

  system.stateVersion = lib.mkDefault "24.05";
}
