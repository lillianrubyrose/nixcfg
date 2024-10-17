{
  lib,
  config,
  pkgs,
  ...
}: {
  options.queernix.desktops.wayfire = {
    enable = lib.mkEnableOption "Enable the Wayfire Environment";
  };

  config = lib.mkIf config.queernix.desktops.wayfire.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting 'celestite my beloved <3' --asterisks --remember --remember-user-session --time --cmd wayfire";
          user = "greeter";
        };
      };
    };

    programs.wayfire = {
      enable = true;
      # xwayland.enable = true;
      plugins = with pkgs.wayfirePlugins; [
        wayfire-plugins-extra # misc
        wf-shell # gtk3 shell
        wcm # config manager
        firedecor # pretty
        windecor # pretty
        wayfire-shadows # pretty
        wwp-switcher # alt tab
        focus-request # misc functionality
      ];
    };

    environment.systemPackages = with pkgs; [
      nautilus # file manager, using cause gtk shell

      # misc
      xdg-utils
      wl-clipboard
      pamixer
    ];

    environment.sessionVariables = {
      NIX_PROFILES = "${pkgs.lib.concatStringsSep " " (
        pkgs.lib.reverseList config.environment.profiles
      )}";
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];

      config = {
        common.default = [
          "wlr"
          "gtk"
        ];
      };
    };

    programs.gnupg.agent.pinentryPackage = pkgs.pinentry-gnome3;
  };
}
