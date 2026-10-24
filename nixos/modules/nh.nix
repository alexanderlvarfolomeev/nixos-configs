{
  flake.nixosModules.nh = {username, ...}: {
    programs.nh = {
      enable = true;
      clean.enable = true;
      # clean.dates = "TODO";
      clean.extraArgs = "--keep-since 7d --keep 5";
      flake = "/home/${username}/nix"; # sets NH_FLAKE variable for you
    };
  };
}
