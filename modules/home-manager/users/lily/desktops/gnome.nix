{
  lib,
  config,
  pkgs,
  ...
}: {
  home-manager.users.lily = lib.mkIf (config.queernix.users.lily.enable && config.queernix.desktops.gnome.enable) {
    programs.gnome-shell = {
      enable = true;
      extensions = [ { package = pkgs.gnomeExtensions.appindicator; } ];
    };
    programs.firefox.enableGnomeExtensions = true;

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
        };
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      };
    };
  };
}
