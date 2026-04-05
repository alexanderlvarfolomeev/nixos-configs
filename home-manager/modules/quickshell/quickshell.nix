{pkgs, ...}: let
  overviewSource = builtins.fetchGit {
    url = "https://github.com/Shanu-Kumawat/quickshell-overview.git";
    name = "quickshell-overview";
    rev = "3486a4aa3748006a2cd99b0fae1ecac16b42091c";
    ref = "main";
  };
in {
  programs.quickshell.enable = true;
  home.packages = [pkgs.kdePackages.qtdeclarative];

  home.file.".config/quickshell/qsbar".source = ./bar;
  home.file.".config/quickshell/overview".source = "${overviewSource}";
}
