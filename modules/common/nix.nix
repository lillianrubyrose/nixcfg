{ inputs, pkgs, ... }:

{
  nix = {
    package = pkgs.nix;
    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      trusted-users = [
        "@wheel"
        "root"
        "nix-ssh"
        "lily"
      ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
    };
  };
}
