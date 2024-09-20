{
  lib,
  config,
  ...
}: {
  home-manager.users.lily = lib.mkIf (config.queernix.users.lily.enable && config.queernix.virtualisation.libvirtd.enable) {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };
}
