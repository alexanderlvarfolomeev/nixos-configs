{pkgs, ...}: {
  xdg.portal = {
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.hyprland = {
      default = [
        "hyprland"
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
    };
  };
}
