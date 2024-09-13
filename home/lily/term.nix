{ ... }:

{
  programs.kitty = {
    enable = true;
    catppuccin.enable = true;

    settings = {
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

      dynamic_background_opacity = "yes";
      background_blur = "1";
      background_opacity = "0.5";
    };
  };

  programs.fastfetch.enable = true;
  programs.hyfetch = {
    enable = true;

    settings = {
      preset = "rainbow";
      mode = "rgb";
      light_dark = "light";
      lightness = 0.4;
      color_align = {
        mode = "horizontal";
      };
      backend = "fastfetch";
    };
  };

  programs.ripgrep.enable = true;
  programs.bat = {
    enable = true;
    catppuccin.enable = true;
  };
  programs.eza.enable = true;

  # for fish
  programs.man.generateCaches = true;
  programs.fish = {
    enable = true;
    catppuccin.enable = true;

    shellInit = ''
    function fish_greeting
       hyfetch
    end
    '';

    shellAliases = {
      env = "echo BAD GIRL";
      cat = "bat -p";
      ls = "eza -lha";
      grep = "rg";
    };
  };

  home.file.".config/fish" = {
    source = ./dots/fish;
    recursive = true;
  };
}
