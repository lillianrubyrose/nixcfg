{
  lib,
  config,
  pkgs,
  ...
}: let
  helix = config.queernix.terminal-editor.helix.enable;
  neovim = config.queernix.terminal-editor.neovim.enable;
in {
  options.queernix.terminal-editor = {
    disable = lib.mkEnableOption "Disable this module, will not set default editor";
    helix.enable = lib.mkEnableOption "Use helix as your default terminal editor";
    neovim.enable = lib.mkEnableOption "Use neovim as your default terminal editor";
  };

  config = lib.mkIf (!config.queernix.terminal-editor.disable) {
    environment = {
      systemPackages =
        lib.optionals helix [pkgs.helix]
        ++ (lib.optionals neovim [pkgs.neovim])
        ++ (lib.optionals (!neovim && !helix) [pkgs.vim]);

      sessionVariables = lib.mkMerge [
        (lib.mkIf helix {EDITOR = "hx";})
        (lib.mkIf neovim {EDITOR = "nvim";})
        (lib.mkIf (!neovim && !helix) {EDITOR = "vim";})
      ];
    };
  };
}
