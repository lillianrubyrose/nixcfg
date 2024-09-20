{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.queernix.grub.uefi.enable {
    boot.loader.grub = {
      splashImage = ./splash.jpg;
      splashMode = "stretch";
    };
  };
}
