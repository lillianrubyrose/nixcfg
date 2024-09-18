{
  inputs,
  pkgs,
  ...
}: {
  system.stateVersion = "24.11"; # change this when reinstalling the system
  networking.hostName = "vm";

  imports = with inputs.self.nixosModules; [
    nix.non-free
    nix.common-settings
    nix.grub.theme
    nix.grub.uefi

    nix.lily.user
    nix.lily.i18n

    nix.desktops.plasma6.desktop
    nix.pipewire

    home-manager.common-settings
    home-manager.lily.user

    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [22];
}
