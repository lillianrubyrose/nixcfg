{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vm";

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}
