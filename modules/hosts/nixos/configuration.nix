{
  flake.nixosModules.nixosConfiguration = {
    imports = [../../../hardware-configuration.nix];

    networking.hostName = "nixos";

    # Keep this at the release used for the first installation.
    system.stateVersion = "26.05";
  };
}
