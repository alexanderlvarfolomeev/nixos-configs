{pkgs}:
with pkgs; {
  socials = [
    telegram-desktop
  ];

  system-analysis = [
    htop
    btop
    libnotify
    wev
    trippy
    nethogs
    sysz
    lazyjournal
    kmon
    bottom
    bandwhich
    heaptrack
    gdb
    mesa-demos
    intel-gpu-tools
  ];

  games = [
    nudoku
    brogue-ce
    nethack
    quadrapassel
  ];

  programming = [
    cargo
    rustc
    python314
    xlsclients
    cmake
    gcc
  ];

  media = [
    ffmpeg
    obs-studio
    vlc
    spotify
    gimp3
    loupe
  ];

  qol = [
    fastfetch
    yt-dlp
    wget
    fzf
    bat
    trashy
    alejandra
    nix-health
    nurl
    stylua
    lua-language-server
    playerctl
    grim
    wl-clipboard-rs
    shadowsocks-rust
    neo
    localsend
    ripgrep
    fd
    flam3
    qosmic
    timg
    chafa
    font-manager
  ];

  ui = [
    pavucontrol
    swaynotificationcenter
    hyprpolkitagent
    iwgtk
    satty
  ];

  tui = [
    bluetui
    tabiew
    lazyssh
    kew
    regex-tui
    fx
    fresh-editor
  ];

  inner-dependencies = [
    cairo
    slurp
    wayfreeze
    tree-sitter
  ];
}
