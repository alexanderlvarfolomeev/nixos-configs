{
  fromFileYAML = pkgs: file:
    builtins.fromJSON (
      # Create a temporary derivation to perform the conversion
      builtins.readFile (
        pkgs.runCommand "${baseNameOf file}-yaml2json" {buildInputs = [pkgs.yj];}
        ''${pkgs.yj}/bin/yj < "${file}" > "$out"''
      )
    );

  renderFlam3 = pkgs: inputXml:
    pkgs.runCommand "${baseNameOf inputXml}-flam3" {buildInputs = [pkgs.flam3];}
    ''${pkgs.flam3}/bin/flam3-render < "${inputXml}" > "$out"'';

  getPkgsByNames = pkgs: names: pkgs.lib.attrVals names pkgs;

  swapFn = fn: arg1: arg2: fn arg2 arg1;
}
