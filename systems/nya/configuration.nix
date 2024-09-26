{
  pkgs,
  nixos-hardware,
  ...
}: {
  imports = [
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
    # ollama = {
    #   enable = true;
    #   rocm = true;
    # };
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
