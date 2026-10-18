{pkgs, ...}: {
  gtk.iconTheme = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
  };

  stylix = {
    enable = true;

    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

    opacity = {
      terminal = 0.9;
    };

    targets = {
      gnome.enable = true;
      alacritty.enable = true;
      kitty.enable = true;
      wezterm.enable = true;
      foot.enable = true;
      waybar.enable = false;
      wofi.enable = false;
      rofi.enable = false;
      micro.enable = false;
      swaync.enable = false;
      gnome-text-editor.enable = false;
      hyprlock.enable = false;
      yazi.enable = true;
      zen-browser.profileNames = ["default"];
      librewolf.profileNames = ["default"];
      # ghostty.enable = true;
      # regreet.enable = true; # not in 26.05
    };

    cursor = {
      name = "Adwaita";
      size = 24;
      package = pkgs.adwaita-icon-theme;
    };

    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 11;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };
  };
}
