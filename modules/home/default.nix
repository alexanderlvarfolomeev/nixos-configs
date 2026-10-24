{inputs, ...}: let
  inherit (inputs) home-manager nixpkgs nixvim stylix zen-browser;
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  upkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  imports = [home-manager.flakeModules.home-manager];

  flake.homeModules.default = ../../home-manager/home.nix;

  flake.homeConfigurations.aorise = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    extraSpecialArgs = {
      inherit inputs system upkgs;
    };

    modules = [
      stylix.homeModules.stylix
      nixvim.homeModules.nixvim
      zen-browser.homeModules.twilight
      ../../home-manager/home.nix
    ];
  };
}
