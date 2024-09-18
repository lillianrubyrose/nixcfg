{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./common/nix.nix
    ./common/i18n.nix
    ./common/pipewire.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.networkmanager.enable = true;

  environment = {
    systemPackages = with pkgs; [
        helix # terminal editor of choise 
        wget
      ];

    sessionVariables = {
      EDITOR = "hx";
    };
  };

  programs = {
    git.enable = true;
    gnome-disks.enable = true;
  };

  services.gvfs.enable = true;

  security.polkit.enable = true;

  system.stateVersion = lib.mkDefault "24.05";
}
