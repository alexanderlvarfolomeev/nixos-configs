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

  fromFileYAML = pkgs: file:
    builtins.fromJSON (
      # Create a temporary derivation to perform the conversion
      builtins.readFile (
        pkgs.runCommand "${file}-yaml2json" {buildInputs = [pkgs.yj];}
        ''${pkgs.yj}/bin/yj < "${file}" > "$out"''
      )
    );

  getPkgsByNames = pkgs: names: pkgs.lib.attrVals names pkgs;

  swapFn = fn: arg1: arg2: fn arg2 arg1;
}
