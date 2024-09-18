{
  modulesPath,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko-config.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    openFirewall = true;
    settings.PasswordAuthentication = false;
  };

  security.pam = {
    sshAgentAuth.enable = true;
    services.sudo.sshAgentAuth = true;
  };

  networking.hostName = "wu-vps";
  networking.useDHCP = true;

  environment.systemPackages = with pkgs; [
    curl
    gitMinimal
    helix
  ];

  users.users = {
    root.openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIIfDROPdGPM9xdM8fEpC9rVg9OOhyLee6JTSH4LeQZj4AAAABHNzaDo= ssh:"
    ];
    lily = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIIfDROPdGPM9xdM8fEpC9rVg9OOhyLee6JTSH4LeQZj4AAAABHNzaDo= ssh:"
      ];
    };
  };

  time.timeZone = "UTC";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  networking.firewall.allowedTCPPorts = [
    22
  ]; # 22 is for git
  networking.firewall.allowedUDPPorts = [ ];

  system.stateVersion = "24.05"; # dont change unless reinstalling with new version
}
