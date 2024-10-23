{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # inputs.nixos-niri.nixosModules.niri
  ];

  options.queernix.desktops.niri = {
    enable = lib.mkEnableOption "Enable the Niri Environment";
  };

  config = lib.mkIf config.queernix.desktops.niri.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting 'celestite my beloved <3' --asterisks --remember --remember-user-session --time --cmd niri-session";
          user = "greeter";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      nautilus # file manager, using cause gtk shell

      # misc
      xdg-utils
      wl-clipboard
      pamixer
      xwayland-satellite
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
  };
}
