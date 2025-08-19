{ pkgs, ... }:
{
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    telegram-desktop
    font-manager

    ffmpeg
    htop
    neofetch
    nwg-bar
    yt-dlp
    wget
    pavucontrol
    wlogout
    ueberzugpp
    swaynotificationcenter
    hyprpolkitagent
    obs-studio
    discord
    iwgtk
    fzf
    nudoku
    cairo
    helvum
    vlc
    yandex-music
    bat
    btop
    trashy
    alejandra    
  ];
}
