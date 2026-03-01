{pkgs, upkgs, ...}: {
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.alacritty = {
    enable = true;
    # TODO: write separate config for fullscreen
    settings = {
      font.offset = {
        y = 2; # disables bottom padding in fullscreen for neo
       };
    };
  };

  programs.quickshell.enable = true;

  programs.vscode = {
    enable = true;
    profiles.default.userSettings = {
      "git.openRepositoryInParentFolders" = "never";
      "editor.tabSize" = 2;
    };
  };

  programs.zed-editor.enable = true;

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
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

    libnotify
    satty
    wayfreeze
    wl-clipboard-rs
    # useful to get keyboard keys
    wev

    lazygit

    bluetui # check bluetuith

    # nice experiments
    neo
    trippy
    nethogs # laggy
    sysz
    brogue-ce
    zellij # laggy
    tmux # check diff with zellij, zellij prettier, but has too many unused space
    tabiew
    timg
    lazyssh # could be useful someday
    kew
    chafa
    oha # not very useful on dayly routine

    # to experiment
    # twig         # not in pkgs, quite narrow usage
    # dashbrew     # not in pkgs
    # nerdlogs     # not in pkgs
    # ntc          # not in pkgs
    # carbonyl     # not in pkgs
    # browsh
    # astromenace
    # pond         # not in pkgs
    # tui-slides   # not in pkgs
    # doxx
    # desktop-tui  # not in pkgs
    # radiogogo    # not in pkgs
    # image-sorter # not in pkgs, but could be very useful
    # upkgs.wifitui
    # akhq         # not in pkgs

    # experiments

    # failed experiments
    # atop      # quiet loaded UI
    # cbonsai   # fun for final image, but growth
    # bastet    # not quiet useful
    # zee       # outdated version
    # wtfutil   # issues/1714
    # chawan    # does not work well in css-bloated pages
    # astroterm # interesting app, but no idea of usage
    # slides    # not useful
    # ctune     # Failed to fetch: Curl KO / HTTP code 200
    # asak      # no sound

    shadowsocks-rust
  ];
}
