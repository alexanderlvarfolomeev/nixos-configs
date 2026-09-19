{pkgs, ...}: {
  programs.direnv.enable = true;

  # TODO: delete
  home.packages = with pkgs; [
    jetbrains.rust-rover
  ];
}
