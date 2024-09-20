# This gets all modules in folders in this directory recursively and puts them into-
# an attribute set.
#
# If you have a nix module and a directory with the same name in the same directory-
# an error will be thrown.
{lib, ...}: let
  inherit (builtins) trace;
  inherit (lib.debug) traceVal;

  getModulesInDir = folder: let
    files =
      builtins.filter
      (file: (lib.hasSuffix ".nix" file))
      (map (name: "${folder}/${name}") (builtins.attrNames (lib.filterAttrs (name: type: type != "directory") (builtins.readDir folder))));

    modules = map (file: let
      name = lib.removeSuffix ".nix" (baseNameOf file);
    in
      lib.nameValuePair name (import file))
    files;
  in
    lib.listToAttrs modules;

  # The behavior of this function is to not search the initial folder for any modules
  # but the folders inside of itself, then does that recursively.
  getSubDirModulesRecursive = folder: let
    folderNames = builtins.attrNames (lib.filterAttrs (k: v: v == "directory") (builtins.readDir folder));
    nixFileNames = map (k: (lib.removeSuffix ".nix" k)) (builtins.attrNames (lib.filterAttrs (k: v: (lib.hasSuffix ".nix" k) && v != "directory") (builtins.readDir folder)));

    _duplicateCheck =
      if lib.lists.mutuallyExclusive folderNames nixFileNames
      then 0
      else throw "${toString folder} has a folder and nix module with the same name inside";

    folderPaths = map (name: "${(toString folder)}/${name}") folderNames;
    folderNamesToPaths = builtins.listToAttrs (lib.zipListsWith (folder: path: lib.nameValuePair folder path) folderNames folderPaths);
    modules = builtins.mapAttrs (name: getModulesInDir) folderNamesToPaths;
    restModules = builtins.mapAttrs (name: getSubDirModulesRecursive) folderNamesToPaths;
  in
    lib.attrsets.recursiveUpdate modules restModules;
in
  getSubDirModulesRecursive ./.
