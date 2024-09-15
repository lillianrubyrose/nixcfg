{ pkgs, ... }:

{
  imports = [ ./ollama.nix ];

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    zed-editor
    devenv
    nixfmt-rfc-style

    (catppuccin-kde.override {
      accents = [ "lavender" ];
      flavour = [
        "mocha"
        "latte"
      ];
    })
    (catppuccin-sddm.override { flavor = "latte"; }) # just always use latte for sddm
    (btop.override { rocmSupport = true; })
  ];

  programs.fish.enable = true;
  users.users.lily = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "video"
      "networkmanager"
    ];
    shell = pkgs.fish;
  };
}
