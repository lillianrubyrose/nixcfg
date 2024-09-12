{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-T-FORCE_TM8FPZ002T_TPBF2308010020302940";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountOptions = [ "umask=0077" "defaults" ];
                mountpoint = "/boot/efi";
              };
            };
            root = {
              end = "-32G";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];

                subvolumes = {
                  "/@" = {
                     mountpoint = "/";
                  };

                  "/@home" = {
                     mountOptions = [ "compress=zstd:1" ];
                     mountpoint = "/home";
                  };

                  "/@log" = {
                     mountOptions = [ "compress=zstd:3" ];
                     mountpoint = "/var/log";
                  };

                  "/@nix" = {
                     mountOptions = [ "compress=zstd:1" "noatime" ];
                     mountpoint = "/nix";
                  };
                };

                mountpoint = "/partition-root";
              };
            };
            swap = {
               size = "100%";
               content = {
                  type = "swap";
                  resumeDevice = true;
               };
            };
          };
        };
      };
    };
  };
}
