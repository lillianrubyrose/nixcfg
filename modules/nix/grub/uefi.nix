{...}: {
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
}
