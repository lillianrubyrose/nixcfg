{ pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    checkConfig = false; # until https://github.com/nix-community/home-manager/issues/5379
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      gaps.outer = 5;
      gaps.inner = 3;

      output = {
        "DP-1" = {
          mode = "3840x2160@240Hz";
          scale = "1.5";
          bg = "~/.config/sway/bg.jpg fill";
        };
        "DP-2" = {
          mode = "1920x1080@164.917Hz";
          scale = "1";
        };
      };
    };

    extraConfig = ''
    blur true
    blur_passes 3
    blur_radius 3

    shadows true
    shadow_blur_radius 10
    shadow_color #1A1A1AEE

    corner_radius 10
    '';
  };

  home.file.".config/sway/bg.jpg" = {
    source = ../../hosts/grub-splash.jpg;
  };
}
