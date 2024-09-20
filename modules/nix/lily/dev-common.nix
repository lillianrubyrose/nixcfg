{
  pkgs,
  zed,
  system,
  ...
}: let
  zed-fhs = pkgs.buildFHSUserEnv {
    name = "zed";
    targetPkgs = _pkgs: [zed.packages.${system}.zed-editor];
    runScript = "zed";
    meta.mainProgram = "zed";
  };
in {
  environment.systemPackages =
    [zed-fhs]
    ++ (with pkgs; [
      # zed-editor from source
      # zed.packages.${system}.zed-editor

      devenv
      alejandra
    ]);
}
