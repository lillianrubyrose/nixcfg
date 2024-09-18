{pkgs, ...}: {
  nix = {
    settings = {
      trusted-users = [
        "@wheel"
        "root"
        "nix-ssh"
      ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  programs.git.enable = true;
  environment = {
    systemPackages = with pkgs; [
      helix # terminal editor of choice
      wget
    ];

    sessionVariables = {
      EDITOR = "hx";
    };
  };
}
