{ inputs, lib, pkgs, ... }:

{
  nix = {
     package = pkgs.nix;
     registry.nixpkgs.flake = inputs.nixpkgs;

     settings = {
       trusted-users = [ "@wheel" "root" "nix-ssh" "lily" ];
       auto-optimise-store = true;
       experimental-features = [ "nix-command" "flakes" ];
     };

     gc = {
        automatic = true;
        dates = "weekly";
     };
  };

  networking.networkmanager.enable = true;

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
    #keyMap = "us"; # after adding an Xwayland setup, disable this and enable useXkbConfig instead
    useXkbConfig = true; # use xkb.options in tty.
  };

  sound.enable = true;
  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      vim wget git
    ];

    sessionVariables = {
      EDITOR = "vim";
    };
  };

  users.users.lily = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "video"
      "networkmanager"
    ];
    shell = pkgs.fish;
  };

  programs = {
    fish.enable = true;

    git = {
      enable = true;
      lfs.enable = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  system.stateVersion = lib.mkDefault "24.05";
}
