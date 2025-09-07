{ pkgs, ... }:
{
  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      allow_images = true;
      width = 350;
      height = 450;
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland-unwrapped;
    terminal = "alacritty";
    theme = ./rofi-style.rasi;
  };

  home.file.".config/rofi/rofi-header.png".source = ./rofi-header.png;
  home.file.".config/wofi/style.css".source = ./wofi-style.css;
}
