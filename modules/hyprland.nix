{ inputs, pkgs, ... }:

let
  hyprland-pkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting 'celestite my beloved <3' --asterisks --remember --remember-user-session --time --cmd Hyprland";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting 'celestite my beloved <3' --asterisks --remember --remember-user-session --time --cmd sway";
        user = "greeter";
      };
    };
  };

  # hardware.opengl = {
  #   package = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa.drivers;

  #   driSupport32Bit = true;
  #   package32 = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.pkgsi686Linux.mesa.drivers;
  # };

  # programs.hyprland = {
  #   enable = true;
  #   package = hyprland-pkgs.hyprland;
  #   portalPackage = hyprland-pkgs.xdg-desktop-portal-hyprland;
  #   xwayland.enable = true;
  # };

  environment.systemPackages = with pkgs; [
    waybar # bar
    wofi # app launcher

    gnome.nautilus # file manager
  ];
}
