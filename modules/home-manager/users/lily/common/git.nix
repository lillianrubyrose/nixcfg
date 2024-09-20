{
  lib,
  config,
  ...
}: {
  home-manager.users.lily = lib.mkIf config.queernix.users.lily.enable {
    programs.gpg.enable = true;
    programs.git = {
      enable = true;
      ignores = [
        "*~"
        "*.swp"
      ];

      delta = {
        enable = true;
        catppuccin.enable = true;
      };

      userName = "Lillian Rose";
      userEmail = "me@lillianro.se";
      extraConfig = {
        user.signingKey = "985A88CE54A3CB82";
        commit.gpgsign = true;
        tag.gpgsign = true;

        init.defaultBranch = "mistress";

        core.autocrlf = "input";

        push.autoSetupRemote = true;
      };
    };
  };
}
