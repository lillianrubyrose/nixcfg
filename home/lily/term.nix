{ ... }:

{
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
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.fish = {
    enable = true;

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

  home.file.".config/bat" = {
    source = ./dots/bat;
  };

  home.file.".config/kitty" = {
    source = ./dots/kitty;
  };

  home.file.".config/fish" = {
    source = ./dots/fish;
    recursive = true;
  };
}
