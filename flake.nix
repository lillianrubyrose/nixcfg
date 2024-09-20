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

    zed.url = "github:zed-industries/zed/v0.154.0-pre";
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
    supportedSystems = [
      "x86_64-linux"
    ];

    mkSystem = hostname: system: pkgs:
      pkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs home-manager zed nixpkgs-stable system catppuccin nixos-hardware hostname;
        };

        modules = [
          ./systems/${hostname}/configuration.nix
          home-manager.nixosModules.home-manager
          disko.nixosModules.disko
          catppuccin.nixosModules.catppuccin
        ];
      };

    allSupportedSystems = nixpkgs.lib.genAttrs supportedSystems;
  in {
    formatter = allSupportedSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosModules = import ./modules {lib = nixpkgs.lib;};

    nixosConfigurations = {
      # desktop
      nya = mkSystem "nya" "x86_64-linux" nixpkgs;

      vm = mkSystem "vm" "x86_64-linux" nixpkgs;

      # pufferfish.host 2C 8GB 5950x vps.
      # runs NixOS stable.
      # the VirtFusion panel doesn't have NixOS for an option so NixOS has to be installed manually with kexec images.
      wu-vps = mkSystem "wu-vps" "x86_64-linux" nixpkgs-stable;
    };
  };
}
