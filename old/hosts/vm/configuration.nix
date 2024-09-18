{...}: {
  imports = [
    ../grub.nix
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  networking.hostName = "vm";

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [22];

  # doesnt work under hyprland in VM
  environment.sessionVariables.KITTY_DISABLE_WAYLAND = "0";
}
