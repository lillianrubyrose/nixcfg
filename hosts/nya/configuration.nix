{ pkgs, ... }:

{
  imports =
    [
      ../grub.nix
      ./hardware-configuration.nix
      ./disko-config.nix
    ];

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 25565 ];

  networking.hostName = "nya";
}
