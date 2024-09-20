# These are what I believe to be sane defaults so these are not feature gated.
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
      wget
    ];
  };
}
