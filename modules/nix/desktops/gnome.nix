{
  lib,
  config,
  pkgs,
  ...
}: {
  options.queernix.desktops.gnome = {
    enable = lib.mkEnableOption "Enable the Gnome DE";
  };

  config = lib.mkIf config.queernix.desktops.gnome.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    services.gnome.gnome-browser-connector.enable = true;

    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [adwaita-icon-theme gnome-settings-daemon];
    environment.sessionVariables = {
      NIX_PROFILES = "${pkgs.lib.concatStringsSep " " (
        pkgs.lib.reverseList config.environment.profiles
      )}";
    };
  };
}
