{
  description = "NixOS flake for lily :3 memwemmwemwmewemwew";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # zed.url = "github:zed-industries/zed/v0.156.0-pre";
    zed.url = "github:RemcoSmitsDev/zed/debugger";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixos-niri.url = "github:sodiboo/niri-flake";

    stylix.url = "github:danth/stylix";
  };

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    disko,
    home-manager,
    nixos-hardware,
    zed,
    darwin,
    nixos-cosmic,
    nixos-niri,
    stylix,
    ...
  } @ inputs: let
    mkSystem = hostname: system: pkgs:
      pkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs home-manager zed nixpkgs-stable system stylix nixos-hardware hostname;
        };

        modules = [
          ./modules
          ./systems/${hostname}/configuration.nix
          home-manager.nixosModules.home-manager
          disko.nixosModules.disko
          stylix.nixosModules.stylix
        ];
      };

    forAllSystems = fn:
      nixpkgs.lib.genAttrs ["x86_64-linux"] (system:
        fn (import nixpkgs {
          inherit system;
        }));
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          statix # linter
          deadnix # finds dead code i guess
          alejandra # formatter
          nil # lsp
          nixd # lsp used in zed nix plugin. why?qwq
          nvd # for nix diffs
        ];
      };
    });

    nixosConfigurations = {
      # desktop
      nya = mkSystem "nya" "x86_64-linux" nixpkgs;

      desktop-vm = mkSystem "desktop-vm" "x86_64-linux" nixpkgs;
      server-vm = mkSystem "server-vm" "x86_64-linux" nixpkgs;

      # pufferfish.host 2C 8GB 5950x vps.
      # runs NixOS stable.
      # the VirtFusion panel doesn't have NixOS for an option so NixOS has to be installed manually with kexec images.
      # wu-vps = mkSystem "wu-vps" "x86_64-linux" nixpkgs-stable;
    };

    darwinConfigurations = {
      akita = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./modules
          ./systems/akita/configuration.nix
          home-manager.darwinModules.home-manager
          stylix.darwinModules.stylix
        ];
      };
    };
  };
}
