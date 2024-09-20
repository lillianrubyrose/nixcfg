{
  lib,
  config,
  pkgs,
  ...
}: {
  options.queernix.desktops.plasma6 = {
    enable = lib.mkEnableOption "Enable the Plasma6 DE";
  };

  config = lib.mkIf config.queernix.desktops.plasma6.enable {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    programs.dconf.enable = true;

    environment.sessionVariables = {
      NIX_PROFILES = "${pkgs.lib.concatStringsSep " " (
        pkgs.lib.reverseList config.environment.profiles
      )}";
    };
  };
}
