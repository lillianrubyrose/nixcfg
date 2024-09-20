{pkgs, ...}: {
  programs.fish.enable = true;
  users.users.lily = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "video"
      "networkmanager"
      "libvirtd"
    ];
    shell = pkgs.fish;
  };

  nix.settings.trusted-users = ["lily"];
}
