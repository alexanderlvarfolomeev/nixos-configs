{
  description = "Base system flake";

  # inputs must be constant
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";

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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
    (inputs.import-tree ./modules);
}
