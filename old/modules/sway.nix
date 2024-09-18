{pkgs, ...}: {
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
    waybar # bar
    nautilus # file manager

    grimblast # screenshots

    # misc
    xdg-utils
    wl-clipboard

    dconf
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
}
