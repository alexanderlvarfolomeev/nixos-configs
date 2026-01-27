{pkgs, upkgs, ...}: {
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.alacritty.enable = true;

  programs.vscode = {
    enable = true;
    profiles.default.userSettings = {
      "git.openRepositoryInParentFolders" = "never";
      "editor.tabSize" = 2;
    };
  };

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
    # discord
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
    slurp
    grim
    quickshell

    libnotify
    satty
    wayfreeze
    wl-clipboard-rs
    # useful to get keyboard keys
    wev

    lazygit
  ];
}
