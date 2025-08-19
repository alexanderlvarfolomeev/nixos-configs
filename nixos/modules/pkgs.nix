{
  config,
  pkgs,
  ...
}: {
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    brightnessctl
    home-manager
    unzip
    zip
    jq
    imagemagick
    file
    lua
  ];
}
