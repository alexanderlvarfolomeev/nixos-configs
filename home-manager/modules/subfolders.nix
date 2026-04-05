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
      ./quickshell/quickshell.nix
    ]
    ++ localUtils.dirImports {
      inherit lib;
      dir = ./hypr;
    }
    ++ localUtils.dirImports {
      inherit lib;
      dir = ./editors;
    }
    ++ localUtils.dirImports {
      inherit lib;
      dir = ./file-managers;
    }
    ++ localUtils.dirImports {
      inherit lib;
      dir = ./temu;
    };
}
