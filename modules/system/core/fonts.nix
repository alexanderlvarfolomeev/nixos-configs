{
  flake.nixosModules.fonts = {pkgs, ...}: {
    fonts.packages = with pkgs; [
      corefonts
      dejavu_fonts
      jetbrains-mono
      texlivePackages.hebrew-fonts
      font-awesome
      material-symbols
      powerline-fonts
      powerline-symbols
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      noto-fonts-lgc-plus
      ipafont
      nerd-fonts.jetbrains-mono
    ];
  };
}
