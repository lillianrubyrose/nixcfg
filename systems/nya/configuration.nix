{
  nixosModules,
  pkgs,
  ...
}: {
  system.stateVersion = "24.05"; # change this when reinstalling the system
  networking.hostName = "nya";

  imports = with nixosModules; [
    nix.grub.theme
    nix.grub.uefi

    nix.plasma6.desktop
    nix.plasma6.catppuccin

    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [
    22
    25565
  ];
}
