{ inputs, pkgs, ... }:

let
  hyprland-pkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland-pkgs.hyprland;

    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      "$mod" = "SUPER";

      general = {
	      border_size = 2;
	      gaps_out = 5;
        gaps_in = 3;
        "col.active_border" = "rgb(0D75CD) rgb(FF40B5) rgb(FFFFFF) rgb(FF40B5) rgb(0D75CD) 90deg";
      };

      decoration = {
        blur = {
          enabled = true;
          size = 3;
          passes = 3;
          new_optimizations = true;
        };

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      monitor = [
        "DP-1, 3840x2160@240.0, 0x0, 1"
        "DP-2, 1920x1080@164.92, auto, 1"
      ];

      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod, F2, exec, firefox-developer-edition"
        "$mod, E, exec, nautilus"

        "$mod, Q, killactive"
        "$mod, F, fullscreen"
        "$mod, T, togglefloating"
        "$mod, J, togglesplit"
        
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, Tab, workspace, m+1"
        "$mod SHIFT, Tab, workspace, m-2"

        ", XF86AudioRaiseVolume, exec, pamixer --increase 5"
        ", XF86AudioLowerVolume, exec, pamixer --decrease 5"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        
      ] ++ ( builtins.concatLists ( builtins.genList ( i:
          let ws = toString (i + 1);
          in [
            "$mod, ${ws}, workspace, ${ws}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${ws}"
          ]
        ) 9
      ));

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
      };
    
      env = [
        "NIXOS_OZONE_WL,1"
        #"_JAVA_AWT_WM_NONREPARENTING,1"
        #"QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        #"QT_QPA_PLATFORM,wayland"
        "SDL_VIDEODRIVER,wayland"
        #"GDK_BACKEND,wayland"
        #"XDG_SESSION_TYPE,wayland"
        #"XDG_SESSION_DESKTOP,Hyprland"
        #"XDG_CURRENT_DESKTOP,Hyprland"
        "MOZ_ENABLE_WAYLAND,1"
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      windowrulev2 = [
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "move 69.5% 4%, title:^(Picture-in-Picture)$"
      ];
    };
  };
}
