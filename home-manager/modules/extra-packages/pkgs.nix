{
  pkgs,
  lib,
  localUtils,
  ...
}: let
  extraPackagesNameList = lib.pipe ./packages.yaml [
    (localUtils.fromFileYAML pkgs)
    builtins.attrValues
    builtins.concatLists
  ];
in {
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages =
    localUtils.getPkgsByNames pkgs extraPackagesNameList;
}
