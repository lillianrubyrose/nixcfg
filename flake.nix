{
  description = "NixOS flake for lily :3 memwemmwemwmewemwew";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    catppuccin.url = "github:catppuccin/nix";

    zed.url = "github:zed-industries/zed/v0.153.4-pre";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    disko,
    home-manager,
    nixos-hardware,
    catppuccin,
    zed,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    mkSystem = extraModules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit system;
          inherit home-manager;
          inherit zed;
        };

        modules =
          [
            ./modules/common.nix
            home-manager.nixosModules.home-manager
            disko.nixosModules.disko
            catppuccin.nixosModules.catppuccin
            {
              nixpkgs.config.allowUnfree = true;

              home-manager = {
                extraSpecialArgs = {
                  inherit inputs;
                  inherit catppuccin;
                };

                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "hm-bak";
              };
            }
          ]
          ++ extraModules;
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
        ./modules/plasma.nix
        ./modules/yubikey.nix
        nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.common-gpu-amd
        {
          home-manager.users.lily = import ./home/lily.nix;
        }
      ];

      # pufferfish.host 2C 8GB 5950x vps.
      # runs NixOS stable.
      # the VirtFusion panel doesn't have NixOS for an option so NixOS has to be installed manually with kexec images.
      wu-vps = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./hosts/wu-vps/configuration.nix
        ];
      };
    };
  };
}
