{
  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;
  };

  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      autoLogin = {
        enable = true;
        user = "aorise";
      };
    };
  };

  services.hypridle.enable = true;
  security.pam.services.hyprlock = {};
}
