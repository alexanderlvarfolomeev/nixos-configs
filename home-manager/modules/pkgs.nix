{pkgs, ...}: {
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.alacritty.enable = true;

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
    vlc
    yandex-music
    bat
    btop
    trashy
    alejandra
    nix-health
    nurl
    playerctl
    gimp3
  ];
}
