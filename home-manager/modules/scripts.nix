{
  home.file = builtins.mapAttrs (
    name: _: let
      nameRel = "/" + name;
    in {
      source = ../../scripts + nameRel;
      target = ".local/scripts" + nameRel;
      executable = true;
    }
  ) (builtins.readDir ../../scripts);
}
