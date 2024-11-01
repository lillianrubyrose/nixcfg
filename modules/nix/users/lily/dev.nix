{
  lib,
  config,
  pkgs,
  zed,
  system,
  ...
}: let
  zed-fhs = pkgs.buildFHSEnv {
    name = "zed";
    targetPkgs = _pkgs: [zed.packages.${system}.zed-editor];
    runScript = "${zed.packages.${system}.zed-editor}/bin/zed";
    extraInstallCommands = ''
      ln -s "${zed.packages.${system}.zed-editor}/share" "$out/"
    '';
  };
in {
  options.queernix.users.lily.dev = {
    enable = lib.mkEnableOption "Enable lily's dev stuff";
  };

  config = lib.mkIf config.queernix.users.lily.dev.enable {
    environment.systemPackages =
      [zed-fhs]
      ++ (with pkgs; [
        devenv
        alejandra
      ]);
  };
}
