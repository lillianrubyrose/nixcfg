{
  pkgs,
  catppuccin,
  ...
}: {
  nixpkgs.config.packageOverrides = pkgs: {
    # catppuccin-kde = pkgs.catppuccin-kde.override { accents = [ catppuccin.accent ]; flavour = [ "mocha" "latte" ]; };
    # catppuccin-sddm-corners = pkgs.catppuccin-sddm-corners.override { flavor = "latte"; }; # just always use latte for sddm
    # catppuccin-papirus-folders = pkgs.catppuccin-papirus-folders.override { accent = [ catppuccin.accent ]; flavor = catppuccin.flavor; };
  };

  home.packages = with pkgs; [
    # catppuccin-kde
    # catppuccin-sddm-corners
    # catppuccin-papirus-folders
  ];
}
