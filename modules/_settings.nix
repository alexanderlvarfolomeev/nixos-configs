{inputs}: rec {
  username = "aorise";
  system = "x86_64-linux";
  osVersion = "26.05";

  localUtils = import ../utils.nix;
  upkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
}
