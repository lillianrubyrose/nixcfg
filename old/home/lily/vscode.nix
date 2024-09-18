{pkgs, ...}: {
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

      # misc
      mkhl.direnv
      eamodio.gitlens
      continue.continue
    ];

    userSettings = {
      editor = {
        fontSize = 16;
        fontFamily = "'Hasklig', 'monospace', monospace";
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
}
