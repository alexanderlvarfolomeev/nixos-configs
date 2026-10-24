{
  flake.nixosModules.packages = {pkgs, ...}: {
    programs.firefox.enable = true;
    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    services.udisks2.enable = true;
    nixpkgs.config.allowUnfree = true;

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
  };
}
