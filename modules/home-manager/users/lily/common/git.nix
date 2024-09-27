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
        user.signingKey = "0x9AB58AD0C3A998A5";
        commit.gpgsign = true;
        tag.gpgsign = true;

        init.defaultBranch = "mistress";

        core.autocrlf = "input";

        push.autoSetupRemote = true;
      };
    };
  };
}
