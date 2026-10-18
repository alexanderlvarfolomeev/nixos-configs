{config, inputs, ...}: let
  inherit (inputs) home-manager nixpkgs nixvim stylix zen-browser;
  inherit (import ./_settings.nix {inherit inputs;}) localUtils osVersion system upkgs user;

  homeModuleTree = inputs.import-tree.filter (
    path:
      !(nixpkgs.lib.any (directory: nixpkgs.lib.hasInfix directory path) [
        "/nixvim/configs/"
        "/temu/tmux/"
      ])
  ) ../home-manager/modules;
in {
  imports = [home-manager.flakeModules.home-manager];

  flake.homeModules.default = {
    imports = [homeModuleTree];
  };

  flake.homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.${system};

    extraSpecialArgs = {
      inherit inputs localUtils osVersion system upkgs user;
    };

    modules = [
      stylix.homeModules.stylix
      nixvim.homeModules.nixvim
      zen-browser.homeModules.twilight
      config.flake.homeModules.default
      ../home-manager/home.nix
    ];
  };
}
