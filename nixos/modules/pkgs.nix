{
  inputs,
  moduleWithSystem,
  ...
}: {
  perSystem = {system, ...}: {
    _module.args = {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      upkgs = import inputs.nixpkgs-unstable {
        inherit system;
      };
    };
  };
  flake.nixosModules.pkgs = moduleWithSystem ({pkgs, ...}: {
    programs.firefox.enable = true;

    programs.appimage = {
      # https://wiki.nixos.org/wiki/Appimage
      enable = true;
      binfmt = true;
    };

    services.udisks2.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # /lib64/ld-linux-x86-64.so.2
    # programs.nix-ld.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      brightnessctl
      home-manager
      unzip
      zip
      jq
      imagemagick
      file
      lua
    ];
  });
}
