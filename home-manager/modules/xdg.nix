{
  config,
  pkgs,
  ...
}: let
  defaultBrowser = "zen-twilight.desktop";
in {
  xdg = {
    portal = {
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      config.hyprland = {
        default = ["hyprland" "gtk"];
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
      };
    };

    /*
       Change to this when it will be enabled in branch
    terminal-exec.enable = true;
    */

    # configFile."./xdg-terminals.list".text = "foot.desktop";
    # dataFile."./applications/xterm.desktop".text = "";
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOT_DIR = "${config.home.homeDirectory}/Screenshots";
      };
    };

    # mimeApps = {
    # enable = true;
    #   defaultApplications = {
    #     "text/html" = [defaultBrowser];
    #     "x-scheme-handler/http" = [defaultBrowser];
    #     "x-scheme-handler/https" = [defaultBrowser];
    #     "x-scheme-handler/about" = [defaultBrowser];
    #     "x-scheme-handler/unknown" = [defaultBrowser];
    #   };
    # };
  };

  home.packages = [pkgs.xdg-terminal-exec];
}
