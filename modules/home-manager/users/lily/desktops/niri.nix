{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home-manager.users.lily = lib.mkIf (config.queernix.users.lily.enable && config.queernix.desktops.niri.enable) {
    imports = [
      inputs.nixos-niri.homeModules.niri
    ];

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

    programs.niri = {
      enable = true;
      settings = {
        environment."DISPLAY" = ":0";
        binds = {
          "Mod+Return".action.spawn = ["kitty"];
        };
      };
    };
  };
}
