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
    ]
    ++ localUtils.dirImports {
      inherit lib;
      dir = ./hypr;
    };
}
