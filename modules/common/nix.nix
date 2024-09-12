{ inputs, pkgs, ... }:

{
  nix = {
     package = pkgs.nix;
     registry.nixpkgs.flake = inputs.nixpkgs;

     settings = {
       trusted-users = [ "@wheel" "root" "nix-ssh" "lily" ];
       auto-optimise-store = true;
       experimental-features = [ "nix-command" "flakes" ];
     };

     gc = {
        automatic = true;
        dates = "weekly";
     };
  };
}
