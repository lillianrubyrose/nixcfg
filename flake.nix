{
  description = "NixOS flake for lily :3 memwemmwemwmewemwew";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, disko, home-manager, nixos-hardware, catppuccin, ... } @inputs:
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
          inherit system;
          inherit pkgs-unstable;
          inherit home-manager;
        };

        modules = [
          ./modules/common.nix
          home-manager.nixosModules.home-manager
          disko.nixosModules.disko
          catppuccin.nixosModules.catppuccin
          {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs;
                inherit pkgs-unstable;
                inherit catppuccin;
              };

              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm-bak";
            };
          }
        ] ++ extraModules;
      };
    in {
      nixosConfigurations = {
        vm = mkSystem [
          ./hosts/vm/configuration.nix
          ./modules/lily.nix
          ./modules/plasma.nix
          {
            home-manager.users.lily = import ./home/lily.nix;
          }
        ];

        # desktop
        nya = mkSystem [
          ./hosts/nya/configuration.nix
          ./modules/lily.nix
          # ./modules/sway.nix
          ./modules/plasma.nix
          ./modules/yubikey.nix
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-gpu-amd
          {
            home-manager.users.lily = import ./home/lily.nix;
          }
        ];
      };
    };
}
