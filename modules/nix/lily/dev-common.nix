{
  pkgs,
  zed,
  system,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # zed-editor from source
    zed.packages.${system}.zed-editor

    devenv
    alejandra
  ];
}
