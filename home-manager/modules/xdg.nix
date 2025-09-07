{pkgs, ...}: {
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

    /* Change to this when it will be enabled in branch
    terminal-exec.enable = true;
    */

    
    configFile."./xdg-terminals.list".text = "alacritty.desktop";
    # dataFile."./applications/xterm.desktop".text = "";
  };

  home.packages = [pkgs.xdg-terminal-exec];
}
