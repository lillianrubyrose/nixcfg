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

    mkSystemOld = extraModules:
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
            ./old/modules/common.nix
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

    mkSystem = system: pkgs: extraModules:
      pkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
          inherit (self) nixosModules;
          inherit home-manager;
          inherit zed;
        };

        modules = [
          home-manager.nixosModules.home-manager
          disko.nixosModules.disko
          catppuccin.nixosModules.catppuccin
        ] ++ extraModules;
      };
  in {
    nixosModules = import ./modules {lib = nixpkgs.lib;};

    nixosConfigurations = {
      # desktop
      nya = mkSystem "x86_64-linux" nixpkgs [
        ./systems/nya/configuration.nix
      ];

      # vm = mkSystemOld [
      #   ./old/hosts/vm/configuration.nix
      #   ./old/modules/lily.nix
      #   ./old/modules/plasma.nix
      #   {
      #     home-manager.users.lily = import ./old/home/lily.nix;
      #   }
      # ];

      # nya = mkSystemOld [
      #   ./old/hosts/nya/configuration.nix
      #   ./old/modules/lily.nix
      #   ./old/modules/plasma.nix
      #   ./old/modules/yubikey.nix
      #   nixos-hardware.nixosModules.common-cpu-amd
      #   nixos-hardware.nixosModules.common-gpu-amd
      #   {
      #     home-manager.users.lily = import ./old/home/lily.nix;
      #   }
      # ];

      # pufferfish.host 2C 8GB 5950x vps.
      # runs NixOS stable.
      # the VirtFusion panel doesn't have NixOS for an option so NixOS has to be installed manually with kexec images.
      # wu-vps = nixpkgs-stable.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     disko.nixosModules.disko
      #     ./old/hosts/wu-vps/configuration.nix
      #   ];
      # };
    };
  };
}
