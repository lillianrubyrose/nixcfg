{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              name = "boot";
              size = "1M";
              type = "EF02";
            };
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountOptions = [
                  "umask=0077"
                  "defaults"
                ];
                mountpoint = "/boot";
              };
            };
            root = {
              end = "-4G";
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
                    mountOptions = [
                      "compress=zstd:1"
                      "noatime"
                    ];
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
