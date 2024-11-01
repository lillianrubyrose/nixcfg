{
  lib,
  config,
  ...
}: {
  home-manager.users.lily = lib.mkIf (config.queernix.users.lily.enable && config.queernix.terminal-editor.helix.enable) {
    stylix.targets.helix.enable = true;
    programs.helix.enable = true;
  };
}
