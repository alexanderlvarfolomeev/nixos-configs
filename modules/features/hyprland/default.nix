{
  flake.nixosModules.hyprland = {pkgs, ...}: {
    programs = {
      hyprland = {
        enable = true;
        withUWSM = true;
      };
      hyprlock.enable = true;
    };

    services.displayManager.ly = {
      enable = true;
      x11Support = false;
      settings.animation = "matrix";
    };

    services.hypridle.enable = true;
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;
    environment.systemPackages = [pkgs.gcr];

    security.pam.services = {
      login.enableGnomeKeyring = true;
      hyprlock.enableGnomeKeyring = true;
      ly.enableGnomeKeyring = true;
      greetd.enableGnomeKeyring = true;
      greetd-password.enableGnomeKeyring = true;
      regreet.enableGnomeKeyring = true;
    };
  };
}
