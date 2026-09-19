{
  description = "Base system flake";

  # inputs must be constant
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim/nixos-26.05";

    # Do not override its nixpkgs input, otherwise there can be mismatch between patches and kernel version
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    # waybar.url = "github:Alexays/Waybar/tags/0.14.0"; # https://github.com/Alexays/waybar/issues/4301

    # yazi.url = "github:sxyazi/yazi/refs/tags/v25.5.31"; # https://github.com/sxyazi/yazi/issues/2809

    # not in nixpkgs
    fastpotify = {
      url = "github:crmne/fastpotify/refs/tags/v0.6.0";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    nix-cachyos-kernel,
    stylix,
    nixvim,
    home-manager,
    ...
  } @ inputs: let
    user = "aorise";
    system = "x86_64-linux";
    osVersion = "26.05";
    homeManager = home-manager;
    localUtils = import ./utils.nix;
    upkgs = nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit localUtils homeManager osVersion user nix-cachyos-kernel upkgs;
      };
      modules = [
        ./nixos/configuration.nix
      ];
    };

    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};

      extraSpecialArgs = {
        inherit localUtils osVersion user upkgs inputs system;
      };

      modules = [
        stylix.homeModules.stylix
        nixvim.homeModules.nixvim
        ./home-manager/home.nix
      ];
    };
  };
}
