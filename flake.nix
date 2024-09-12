{
  description = "NixOS flake for lily :3 memwemmwemwmewemwew";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, disko, home-manager, ... } @inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
         inherit system;
         config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
         inherit system;
         config.allowUnfree = true;
      };

      mkSystem = extraModules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit pkgs;
          inherit pkgs-unstable;
          inherit home-manager;
        };

        modules = [
          ./modules/common.nix
          home-manager.nixosModules.home-manager
          disko.nixosModules.disko
          {
            home-manager = {
              extraSpecialArgs = {
                inherit pkgs;
                inherit pkgs-unstable;
              };

              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }
        ] ++ extraModules;
      };
    in {
      nixosConfigurations = {
        vm = mkSystem [
          ./hosts/vm/configuration.nix
          ./modules/lily.nix
          {
            home-manager.users.lily = import ./home/lily.nix;
          }
        ];
      };
    };
}
