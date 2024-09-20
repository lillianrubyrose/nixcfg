{
  pkgs,
  nixos-hardware,
  ...
}: {
  imports = [
    # nix.non-free
    # nix.common-settings
    # nix.grub.theme
    # nix.grub.uefi

    # nix.lily.user
    # nix.lily.i18n
    # nix.lily.dev-common

    # nix.desktops.plasma6.desktop
    # nix.desktops.plasma6.catppuccin
    # nix.yubikey
    # nix.pipewire
    # nix.ollama
    # nix.flatpak
    # nix.libvirtd

    # home-manager.common-settings
    # home-manager.lily.user
    # home-manager.lily.virt-manager-qemu
    ./hardware-configuration.nix
    ./disko-config.nix

    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-gpu-amd
  ];

  system.stateVersion = "24.05"; # change this when reinstalling the system

  boot.kernelPackages = pkgs.linuxPackages_zen;

  environment.systemPackages = with pkgs; [
    (btop.override {rocmSupport = true;})
  ];

  services.openssh.enable = true;
  networking = {
    hostName = "nya";
    firewall.allowedTCPPorts = [
      22
      25565
    ];
    networkmanager.enable = true;
  };

  queernix = {
    yubikey.enable = true;
    pipewire.enable = true;
    ollama = {
      enable = true;
      rocm = true;
    };
    virtualisation.libvirtd.enable = true;
    flatpak.enable = true;
    terminal-editor.helix.enable = true;
    desktops.plasma6.enable = true;
    users.lily = {
      enable = true;
      dev.enable = true;
    };
    grub.uefi.enable = true;
  };
}
