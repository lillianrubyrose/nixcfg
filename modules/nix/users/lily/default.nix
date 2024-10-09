{
  lib,
  config,
  pkgs,
  ...
}: {
  options.queernix.users.lily = {
    enable = lib.mkEnableOption "Enable lily";
  };

  config = lib.mkIf config.queernix.users.lily.enable {
    programs.fish.enable = true;
    users.users.lily = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "input"
        "video"
        "networkmanager"
        "libvirtd"
      ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIIfDROPdGPM9xdM8fEpC9rVg9OOhyLee6JTSH4LeQZj4AAAABHNzaDo= ssh:"
      ];
    };

    environment.systemPackages = with pkgs; [
      signal-desktop
    ];

    nix.settings.trusted-users = ["lily"];

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    console = {
      font = "Lat2-Terminus16";
      useXkbConfig = true;
    };

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
}
