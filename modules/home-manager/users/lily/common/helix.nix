{
  lib,
  config,
  ...
}: {
  home-manager.users.lily = lib.mkIf (config.queernix.users.lily.enable && config.queernix.terminal-editor.helix.enable) {
    programs.helix = {
      enable = true;
      catppuccin.enable = true;
    };
  };
}
