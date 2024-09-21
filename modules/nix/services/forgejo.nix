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

          # LFS_JWT_SECRET_URI = "file:${config.age.secrets.forgejo-lfs-jwt.path}";
        };
        service.DISABLE_REGISTRATION = true;
        actions = {
          ENABLED = true;
          DEFAULT_ACTIONS_URL = "github";
        };

        # security = {
        #   SECRET_KEY_URI = "file:${config.age.secrets.forgejo-global-secret.path}";
        # };

        # oauth2 = {
        # JWT_SECRET = "Oe7IzdnIvL_SipbZ2xWRFD51qy08pnifWLuXsgc5VYM";
        # };
      };
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
