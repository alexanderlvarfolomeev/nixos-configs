{
  pkgs,
  upkgs,
  config,
  ...
}: let
  overviewSource = fetchGit {
    url = "https://github.com/Shanu-Kumawat/quickshell-overview.git";
    name = "quickshell-overview";
    rev = "74918ba66e0714017a6a5bfb9bf2affa66dabbc1";
    ref = "main";
  };
in {
  programs.quickshell.enable = true;

  home.packages = with pkgs; [
    kdePackages.qtdeclarative
    kdePackages.qtimageformats
    kdePackages.qtmultimedia
    kdePackages.qt5compat
    kdePackages.qtwayland
  ];

  home.sessionVariables = {
    QML2_IMPORT_PATH = "${config.home.profileDirectory}/lib/qt-6/qml";
  };

  home.file.".config/quickshell/qsbar".source = ./bar;
  home.file.".config/quickshell/overview".source = "${overviewSource}";
}
