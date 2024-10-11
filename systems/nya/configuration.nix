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
    alsa-scarlett-gui
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

  services.pipewire.extraConfig.pipewire."92-sample-rate" = {
    "context.properties" = {
      "default.clock.allowed-rates" = [48000 96000 192000];
      "default.clock.rate" = 192000;
    };
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
      gaming.enable = true;
    };
    grub.uefi.enable = true;
  };
}
