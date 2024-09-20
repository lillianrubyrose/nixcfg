{
  lib,
  config,
  ...
}: {
  options.queernix.yubikey = {
    enable = lib.mkEnableOption "Enable required services for Yubikey usage";
  };

  config = lib.mkIf config.queernix.yubikey.enable {
    services.pcscd.enable = true;

    programs.gnupg.agent = {
      enable = true;
    };

    security.polkit.enable = true;
  };
}
