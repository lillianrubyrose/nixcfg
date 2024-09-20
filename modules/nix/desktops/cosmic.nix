{
  lib,
  config,
  ...
}: {
  options.queernix.desktops.cosmic = {
    enable = lib.mkEnableOption "Enable the Cosmic DE";
  };

  config = lib.mkIf config.queernix.desktops.cosmic.enable {
    nix.settings = {
      substituters = ["https://cosmic.cachix.org/"];
      trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
    };

    # need to add the flake input back
    # services.desktopManager.cosmic.enable = true;
    # services.displayManager.cosmic-greeter.enable = true;
  };
}
