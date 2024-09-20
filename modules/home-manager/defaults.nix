# These are what I believe to be sane defaults so these are not feature gated.
{inputs, ...}: {
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };

    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";
  };
}
