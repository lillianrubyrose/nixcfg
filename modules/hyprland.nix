{ pkgs-unstable, ... }:

{
  # TODO: Replace with greetd-tuigreet
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # TODO: doesnt really work that goob. try out hyprland flake
  hardware.opengl.package = pkgs-unstable.mesa.drivers;
  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
  };
}
