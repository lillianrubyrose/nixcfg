{
  inputs,
  pkgs,
  ...
}: {
  system.stateVersion = "24.05"; # change this when reinstalling the system
  networking.hostName = "nya";

  imports = with inputs.self.nixosModules; [
    nix.non-free
    nix.common-settings
    nix.grub.theme
    nix.grub.uefi

    nix.lily.user
    nix.lily.i18n
    nix.lily.dev-common

    nix.desktops.plasma6.desktop
    nix.desktops.plasma6.catppuccin
    nix.yubikey
    nix.pipewire
    nix.ollama
    nix.flatpak

    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  nixpkgs.config.rocmSupport = true;

  environment.systemPackages = with pkgs; [
    (btop.override {rocmSupport = true;})
  ];

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [
    22
    25565
  ];
  networking.networkmanager.enable = true;
}
