# This gets all modules in folders in this directory recursively and imports them.
{lib, ...}: let
  getModules = folder: let
    folders =
      map (name: "${folder}/${name}")
      (builtins.attrNames (lib.filterAttrs (_name: type: type == "directory") (builtins.readDir folder)));

    files = builtins.foldl' (acc: folder:
      acc
      ++ builtins.filter (file: (lib.hasSuffix ".nix" file))
      (lib.filesystem.listFilesRecursive folder)) []
    folders;
  in
    files;
in {
  imports = lib.reverseList (getModules ./.);
}
