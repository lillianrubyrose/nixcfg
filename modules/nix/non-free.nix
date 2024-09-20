{
  lib,
  config,
  ...
}: {
  options.queernix.unfreeSoftware = {
    enable = lib.mkEnableOption "Enable unfree software for the primary nixpkgs";
  };

  config = lib.mkIf config.queernix.unfreeSoftware.enable {
    nixpkgs.config.allowUnfree = true;
  };
}
