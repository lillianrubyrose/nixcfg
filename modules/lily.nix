{ pkgs, ... }:

{
  imports = [ ./ollama.nix ];

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
