{
  pkgs,
  localUtils,
  ...
}: let
  flam3_1 = localUtils.renderFlam3 pkgs ./flam_1.flam3;
in {
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    hyprlock.enable = true;
  };

  services = {
    displayManager = {
      #     sddm = {
      #       enable = true;
      #       wayland.enable = true;
      #     };
      #     autoLogin = {
      #       enable = true;
      #       user = "aorise";
      #     };

      ly = {
        enable = true;
        x11Support = false;
        settings = {
          animation = "matrix";
        };
      };
    };
  };

  services.hypridle.enable = true;

  # programs.regreet = {
  #   enable = true;
  #   settings = {
  #     skip_selection = true;
  #     background.path = "${flam3_1}";
  #     GTK = {
  #       application_prefer_dark_theme = true;
  #     };
  #   };
  # };

  # vanilla regreet better
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

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  environment.systemPackages = [pkgs.gcr];

  # do not know which of this is actualy useful
  security.pam.services = {
    login = {
      enableGnomeKeyring = true;
    };
    hyprlock = {
      enableGnomeKeyring = true;
    };
    ly = {
      enableGnomeKeyring = true;
    };
    greetd = {
      enableGnomeKeyring = true;
    };
    greetd-password = {
      enableGnomeKeyring = true;
    };
    regreet = {
      enableGnomeKeyring = true;
    };
  };
}
