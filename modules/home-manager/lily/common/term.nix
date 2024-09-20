_: {
  programs = {
    kitty = {
      enable = true;
      catppuccin.enable = true;

      settings = {
        font_family = "Victor Mono";
        font_size = 14;

        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

        dynamic_background_opacity = "yes";
        background_blur = "1";
        background_opacity = "0.5";
      };
    };

    fastfetch = {
      enable = true;
      settings = {
        display.separator = " ";
        logo = {
          source = "~/.config/fastfetch/logo.png";
          type = "kitty";
        };
        modules = [
          "break"
          {
            key = "╭─󰌢";
            keyColor = "green";
            type = "host";
          }
          {
            key = "├─󰻠";
            keyColor = "green";
            type = "cpu";
          }
          {
            key = "├─󰍛";
            keyColor = "green";
            type = "gpu";
          }
          {
            key = "├─";
            keyColor = "green";
            type = "disk";
          }
          {
            key = "├─󰑭";
            keyColor = "green";
            type = "memory";
          }
          {
            key = "├─󰓡";
            keyColor = "green";
            type = "swap";
          }
          {
            key = "╰─󰍹";
            keyColor = "green";
            type = "display";
          }
          "break"
          {
            key = "╭─";
            keyColor = "yellow";
            type = "shell";
          }
          {
            key = "├─";
            keyColor = "yellow";
            type = "terminal";
          }
          {
            key = "├─";
            keyColor = "yellow";
            type = "wm";
          }
          {
            key = "╰─";
            keyColor = "yellow";
            type = "terminalfont";
          }
          "break"
          {
            format = "{user-name}@{host-name}";
            key = "╭─";
            keyColor = "blue";
            type = "title";
          }
          {
            key = "├─{icon}";
            keyColor = "blue";
            type = "os";
          }
          {
            key = "├─";
            keyColor = "blue";
            type = "kernel";
          }
          {
            key = "╰─󰅐";
            keyColor = "blue";
            type = "uptime";
          }
        ];
      };
    };

    ripgrep.enable = true;
    bat = {
      enable = true;
      catppuccin.enable = true;
    };
    eza.enable = true;

    # for fish
    man.generateCaches = true;
    fish = {
      enable = true;
      catppuccin.enable = true;

      shellInit = ''
        function fish_greeting
           fastfetch
        end
      '';

      shellAliases = {
        env = "echo BAD GIRL";
        cat = "bat -p";
        ls = "eza -lha";
        grep = "rg";
      };
    };
  };

  home.file.".config/fastfetch/logo.png" = {
    source = ./fastfetch-logo.png;
  };
}
