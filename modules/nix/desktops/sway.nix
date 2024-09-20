{
  lib,
  config,
  pkgs,
  ...
}: {
  options.queernix.desktops.sway = {
    enable = lib.mkEnableOption "Enable the Sway WM";
  };

  config = lib.mkIf config.queernix.desktops.sway.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting 'celestite my beloved <3' --asterisks --remember --remember-user-session --time --cmd sway";
          user = "greeter";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      nautilus # file manager

      grimblast # screenshots

      # misc
      xdg-utils
      wl-clipboard
      pamixer
    ];

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

    programs.gnupg.agent.pinentryPackage = pkgs.pinentry-qt;
  };
}
