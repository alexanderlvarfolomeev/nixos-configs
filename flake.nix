{
  description = "Base system flake";

  # inputs must be constant
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # waybar.url = "github:Alexays/Waybar/tags/0.14.0"; # https://github.com/Alexays/waybar/issues/4301

    # yazi.url = "github:sxyazi/yazi/refs/tags/v25.5.31"; # https://github.com/sxyazi/yazi/issues/2809
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    stylix,
    home-manager,
    ...
  } @ inputs: let
    user = "aorise";
    system = "x86_64-linux";
    osVersion = "25.05";
    homeManager = home-manager;
    localUtils = import ./utils.nix;
    upkgs = nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit localUtils homeManager osVersion user;
      };
      modules = [./nixos/configuration.nix];
    };

    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};

      extraSpecialArgs = {
        inherit localUtils osVersion user upkgs inputs;
      };

      modules = [
        stylix.homeModules.stylix
        ./home-manager/home.nix
      ];
    };
  };
}
