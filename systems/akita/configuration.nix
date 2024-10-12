{...}: {
  services.nix-daemon.enable = true;
  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";

  queernix = {
    users.lily.enable = true;
  };
}
