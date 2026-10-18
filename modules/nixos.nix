{config, inputs, ...}: let
  inherit (inputs) home-manager nix-cachyos-kernel nixpkgs;
  inherit (import ./_settings.nix {inherit inputs;}) localUtils osVersion system upkgs user;
in {
  flake.nixosModules.default = {
    imports = [(inputs.import-tree ../nixos/modules)];
  };

  flake.nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    inherit system;

    specialArgs = {
      homeManager = home-manager;
      inherit localUtils nix-cachyos-kernel osVersion upkgs user;
    };

    modules = [
      config.flake.nixosModules.default
      ../nixos/configuration.nix
    ];
  };
}
