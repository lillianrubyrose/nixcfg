{pkgs, config, ...}: {
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  programs.dconf.enable = true;

  environment.sessionVariables = {
    NIX_PROFILES = "${pkgs.lib.concatStringsSep " " (
      pkgs.lib.reverseList config.environment.profiles
    )}";
  };
}
