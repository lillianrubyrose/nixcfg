{
  lib,
  config,
  ...
}: {
  home-manager.users.lily = lib.mkIf (config.queernix.users.lily.enable && config.queernix.users.lily.dev.enable) {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      config.global = {
        # Make direnv messages less verbose
        hide_env_diff = true;
      };
    };
  };
}
