{
  lib,
  config,
  pkgs,
  ...
}: {
  options.queernix.virtualisation.libvirtd = {
    enable = lib.mkEnableOption "Enable libvirtd virtualization";
  };

  config = lib.mkIf config.queernix.virtualisation.libvirtd.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            })
            .fd
          ];
        };
        vhostUserPackages = [pkgs.virtiofsd];
      };
    };
    programs.virt-manager.enable = true;
  };
}
