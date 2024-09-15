{ pkgs, ... }:

{
  imports = [ ./ollama.nix ];

  environment.systemPackages = with pkgs; [ zed-editor devenv ];

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
