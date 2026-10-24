{pkgs, ...}: let
  packageGroups = import ./packages.nix {inherit pkgs;};
in {
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = builtins.concatLists (builtins.attrValues packageGroups);
}
