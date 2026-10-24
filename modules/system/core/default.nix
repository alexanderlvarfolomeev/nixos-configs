{self, ...}: {
  flake.nixosModules.core = {
    imports = with self.nixosModules; [
      boot
      fonts
      locale
      nh
      nix
      user
    ];
  };
}
