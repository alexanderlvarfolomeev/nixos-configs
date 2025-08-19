{ homeManager, ... }: {
  imports = [ homeManager.nixosModules.default ];
  home-manager.backupFileExtension = "backup";
}
