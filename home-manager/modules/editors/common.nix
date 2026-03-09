{pkgs, ...}: {
  # nix language server
  home.packages = [pkgs.nixd];
}
