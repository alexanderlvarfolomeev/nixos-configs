{
  dirImports = {
    lib,
    dir,
  }:
    lib.pipe dir [
      builtins.readDir
      builtins.attrNames
      (builtins.filter (lib.strings.hasSuffix ".nix"))
      (builtins.filter (name: name != "default.nix"))
      (builtins.map (name: dir + ("/" + name)))
    ];
}
