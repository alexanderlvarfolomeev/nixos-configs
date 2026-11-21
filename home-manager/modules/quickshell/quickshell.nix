{inputs, ...}: {
  programs.quickshell = {
    enable = true;
    configs.overview = inputs.quickshell-overview;
  };

  # Keep qsbar linked for ad-hoc named-config runs, while Hyprland deliberately
  # launches the repository path for immediate hot-reload feedback.
  home.file.".config/quickshell/qsbar".source = ./bar;
}
