{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.queernix.users.lily.enable && config.queernix.desktops.plasma6.enable) {
    environment.systemPackages = with pkgs; [
      (catppuccin-kde.override {
        accents = ["lavender"];
        flavour = [
          "mocha"
          "latte"
        ];
      })
      (catppuccin-sddm.override {flavor = "latte";}) # just always use latte for sddm
    ];
  };
}
