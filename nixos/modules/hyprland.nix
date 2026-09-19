{
  programs = {
    hyprland = {
      enable = true;
      # withUWSM = true; # no use for now
    };
    hyprlock.enable = true;
  };

  # services = {
  #   displayManager = {
  #     sddm = {
  #       enable = true;
  #       wayland.enable = true;
  #     };
  #     autoLogin = {
  #       enable = true;
  #       user = "aorise";
  #     };
  #   };
  # };

  services.hypridle.enable = true;
  security.pam.services.hyprlock = {};

  programs.regreet = {
    enable = true;
    settings = {
      skip_selection = true;
      GTK = {
        application_prefer_dark_theme = true;
      };
    };
  };
  # services.greetd = {
  #   enable = true; # also default from regreet
  #   settings = {
  #     main_session = {
  #       command = "start-hyprland";
  #       user = user;
  #     };

  #     default_session = {
  #       command = "start-hyprland -- -c /etc/${greetd_hyprlua}";
  #       user = user;
  #     };
  #   };
  # };
}
