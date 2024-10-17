{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.nixos-cosmic.nixosModules.default
  ];

  options.queernix.desktops.cosmic = {
    enable = lib.mkEnableOption "Enable the Cosmic DE";
  };

  config =
    lib.mkIf config.queernix.desktops.cosmic.enable
    {
      nix.settings = {
        substituters = ["https://cosmic.cachix.org/"];
        trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
      };

      services.desktopManager.cosmic.enable = true;
      services.displayManager.cosmic-greeter.enable = true;
    };
}
