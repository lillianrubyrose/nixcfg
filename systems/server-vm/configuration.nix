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

  networking.firewall.allowedTCPPorts = [ 22 80 443 3000 8080 ];

  queernix = {
    pipewire.enable = true;
    terminal-editor.helix.enable = true;
    users.lily = {
      enable = true;
    };
    grub.uefi.enable = true;
    forgejo.enable = true;
  };

  environment.systemPackages = [ pkgs.p7zip ];

  users.users.root.initialPassword = "vm";
  users.users.lily.initialPassword = "vm";

  # build-vm flags
  virtualisation.vmVariant = {
    virtualisation = {
      diskSize = 1024 * 10;
      memorySize = 8192;
      cores = 16;
      forwardPorts = [
        { from = "host"; host.port = 3000; guest.port = 3000; }
      ];
      sharedDirectories = {
        existing-data = { source = "/home/lily/vm-shared"; target = "/mnt/data"; };
      };
    };
  };
}
