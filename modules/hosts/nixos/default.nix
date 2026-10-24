{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      desktop
      nixosConfiguration
    ];
  };
}
