{self, ...}: {
  flake.nixosModules.desktop = {
    imports = with self.nixosModules; [
      core
      audio
      bluetooth
      home-manager
      hyprland
      network
      packages
      power
      printing
      steam
      zram
    ];
  };
}
