{
  lib,
  config,
  ...
}: {
  options.queernix.grub.uefi = {
    enable = lib.mkEnableOption "Enable GRUB bootloader with basic UEFI support";
  };

  config = lib.mkIf config.queernix.grub.uefi.enable {
    boot.loader.grub = {
      enable = true;
      copyKernels = true;
      efiInstallAsRemovable = true;
      efiSupport = true;

      devices = ["nodev"];
      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';
    };

    boot.loader = {
      efi = {
        efiSysMountPoint = "/boot/efi";
      };
    };
  };
}
