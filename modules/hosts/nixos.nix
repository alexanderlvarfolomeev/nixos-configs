{
  self,
  config,
  inputs,
  lib,
  ...
}: let
  inherit (import ../_settings.nix {inherit inputs;}) localUtils osVersion upkgs username;
in {
  imports = [(inputs.import-tree ../../nixos/modules)];
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = with self.nixosModules; [
      ../../hardware-configuration.nix
      # ../../nixos/configuration.nix
      {
        system.stateVersion = osVersion;
        _module.args = {
          inherit username;
        };
      }
      audio
      bluetooth
      boot
      fonts
      home-manager
      hyprland
      locale
      network
      nh
      nix
      pkgs
      power
      print
      steam
      user
      zram
    ];
  };
}
