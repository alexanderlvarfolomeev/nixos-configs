{ user, ... }:
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/${user}/nix"; # sets NH_FLAKE variable for you
  };
}
