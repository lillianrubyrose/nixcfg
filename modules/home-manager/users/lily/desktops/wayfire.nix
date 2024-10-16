{
  lib,
  config,
  ...
}: {
  home-manager.users.lily = lib.mkIf (config.queernix.users.lily.enable && config.queernix.desktops.wayfire.enable) {
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      "_JAVA_AWT_WM_NONREPARENTING" = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      GDK_BACKEND = "wayland";
      XDG_SESSION_DESKTOP = "wayfire";
      MOZ_ENABLE_WAYLAND = "1";
    };
  };
}
