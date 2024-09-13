{ pkgs, ... }:

{
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

    gnome.nautilus # file manager
  ];
}
