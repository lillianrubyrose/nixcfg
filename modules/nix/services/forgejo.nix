{
  lib,
  config,
  pkgs,
  ...
}: {
  options.queernix.forgejo = {
    enable = lib.mkEnableOption "Enable Forgejo service";
  };

  config = lib.mkIf config.queernix.forgejo.enable {
    services.forgejo = {
      enable = true;
      database.type = "sqlite3";
      # Enable support for Git Large File Storage
      lfs.enable = true;
      dump = {
        enable = true;
        type = "tar.lz4";
        interval = "daily";
      };
      settings = {
        server = {
          DOMAIN = "localhost";
          # You need to specify this to remove the port from URLs in the web UI.
          ROOT_URL = "http://10.0.2.15:3000";
          HTTP_PORT = 3000;
        };
        # You can temporarily allow registration to create an admin user.
        service.DISABLE_REGISTRATION = true;
        # Add support for actions, based on act: https://github.com/nektos/act
        actions = {
          ENABLED = true;
          DEFAULT_ACTIONS_URL = "github";
        };

        # oauth2 = {
          # JWT_SECRET = "Oe7IzdnIvL_SipbZ2xWRFD51qy08pnifWLuXsgc5VYM";
        # };
        # Sending emails is completely optional
        # You can send a test email from the web UI at:
        # Profile Picture > Site Administration > Configuration >  Mailer Configuration
        # mailer = {
        #   ENABLED = true;
        #   SMTP_ADDR = "mail.example.com";
        #   FROM = "noreply@${srv.DOMAIN}";
        #   USER = "noreply@${srv.DOMAIN}";
        # };
      };
      # mailerPasswordFile = config.age.secrets.forgejo-mailer-password.path;
    };

    environment.systemPackages = let
      cfg = config.services.forgejo;
      forgejo-cli = pkgs.writeScriptBin "forgejo-cli" ''
        #!${pkgs.runtimeShell}
        cd ${cfg.stateDir}
        sudo=exec
        if [[ "$USER" != forgejo ]]; then
          sudo='exec /run/wrappers/bin/sudo -u ${cfg.user} -g ${cfg.group} --preserve-env=FORGEJO_WORK_DIR --preserve-env=FORGEJO_CUSTOM'
        fi
        # Note that these variable names will change
        export FORGEJO_WORK_DIR=${cfg.stateDir}
        export FORGEJO_CUSTOM=${cfg.customDir}
        $sudo ${lib.getExe cfg.package} "$@"
      '';
    in [
      forgejo-cli
    ];
  };
}
