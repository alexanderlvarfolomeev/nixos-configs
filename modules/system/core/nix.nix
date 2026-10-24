{
  flake.nixosModules.nix = {
    nix.settings.experimental-features = ["pipe-operators" "nix-command" "flakes"];
  };
}
