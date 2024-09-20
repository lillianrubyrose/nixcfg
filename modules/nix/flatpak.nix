{
  lib,
  config,
  ...
}: {
  options.queernix.flatpak = {
    enable = lib.mkEnableOption "Enable Flatpak";
  };

  config = lib.mkIf config.queernix.flatpak.enable {
    services.flatpak.enable = true;
    xdg.portal.enable = true;
  };
}
