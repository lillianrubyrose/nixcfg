{ pkgs, ... }:
{
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
}