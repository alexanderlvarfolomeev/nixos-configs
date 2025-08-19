{
    description = "Base system flake";

    # inputs must be constant
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        stylix = {
          url = "github:nix-community/stylix/release-25.05";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
          url = "github:nix-community/home-manager/release-25.05";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        yazi.url = "github:sxyazi/yazi/refs/tags/v25.5.31";
    };

    outputs = { nixpkgs, stylix, home-manager, yazi, ... }: let
        user = "aorise";
        system = "x86_64-linux";
        osVersion = "25.05";
        homeManager = home-manager;
        localUtils = import ./utils.nix;
    in {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
                inherit localUtils homeManager osVersion user;
            };
            modules = [ ./nixos/configuration.nix ];
        };

        homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.${system};

            extraSpecialArgs = {
                inherit localUtils osVersion user yazi;
            };
            modules = [
              stylix.homeModules.stylix
              ./home-manager/home.nix
            ];
        };
    };
}
