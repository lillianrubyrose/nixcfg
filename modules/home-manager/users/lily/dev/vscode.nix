{
  lib,
  config,
  pkgs,
  ...
}: {
  home-manager.users.lily = lib.mkIf (config.queernix.users.lily.enable && config.queernix.users.lily.dev.enable) {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      mutableExtensionsDir = false;

      extensions = with pkgs.vscode-extensions; [
        # visual
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        usernamehw.errorlens

        # rust
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        serayuzgur.crates

        # nix
        jnoortheen.nix-ide

        # astro
        astro-build.astro-vscode
        unifiedjs.vscode-mdx

        # misc
        mkhl.direnv
        eamodio.gitlens
        continue.continue
        bradlc.vscode-tailwindcss
      ];

      userSettings = {
        editor = {
          fontSize = 16;
          fontFamily = "'Victor Mono', 'monospace', monospace";
          inlayHints.enabled = "offUnlessPressed";
          minimap.enabled = false;
        };

        workbench = {
          preferredLightColorTheme = "Catppuccin Latte";
          preferredDarkColorTheme = "Catppuccin Mocha";
          iconTheme = "catppuccin-latte"; # wish there was a way to match this to the color theme....
        };
        "window.autoDetectColorScheme" = true;

        rust-analyzer = {
          check.command = "clippy";
          inlayHints.closureStyle = "rust_analyzer";
        };

        nix = {
          formatterPath = "alejandra";
          enableLanguageServer = true;
          serverPath = "nil";
        };
      };
    };
  };
}
