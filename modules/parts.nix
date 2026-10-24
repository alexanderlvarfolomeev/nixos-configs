{inputs, ...}: {
  systems = ["x86_64-linux"];

  perSystem = {system, ...}: {
    _module.args.upkgs = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  };
}
