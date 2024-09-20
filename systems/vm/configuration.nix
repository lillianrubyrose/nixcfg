{pkgs, ...}: {
  system.stateVersion = "24.11"; # change this when reinstalling the system
  networking.hostName = "vm";

  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true; # enable copy and paste between host and guest
    openssh.enable = true;
  };

  networking.firewall.allowedTCPPorts = [22];

  queernix = {
    pipewire.enable = true;
    terminal-editor.helix.enable = true;
    desktops.plasma6.enable = true;
    users.lily = {
      enable = true;
    };
    grub.uefi.enable = true;
  };
}
