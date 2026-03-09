{
  lib,
  localUtils,
  ...
}: {
  imports =
    [
      ./extra-packages/pkgs.nix
      ./wlogout/wlogout.nix
      ./rofi/rofi.nix
      ./waybar/waybar.nix
    ]
    ++ localUtils.dirImports {
      inherit lib;
      dir = ./hypr;
    };
}
