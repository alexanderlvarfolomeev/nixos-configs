{
  pkgs,
  # upkgs,
  lib,
  localUtils,
  ...
}: {
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

  programs.zed-editor = {
    enable = true;
    extensions = ["nix"];
    userSettings = {
      buffer_font_family = lib.mkForce "JetBrainsMono NF";
      buffer_font_size = lib.mkForce 18;

      ui_font_family = lib.mkForce "Noto Sans";
      ui_font_size = lib.mkForce 17;

      lsp = {
        nixd = {
          settings = {
            diagnostic = {
              suppress = ["sema-extra-with"];
            };
          };
        };
      };
      languages = {
        Nix = {
          language_servers = ["nixd" "!nil"];
          formatter = {
            external = {
              command = "alejandra";
              arguments = ["--quiet" "--"];
            };
          };
        };
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  home.packages = with pkgs;
    [
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

      bluetui # check btest-sectionluetuith

      shadowsocks-rust
      nixd

      # nice experiments
      neo
      trippy
      nethogs # laggy
      sysz
      lazyjournal
      brogue-ce
      zellij # laggy
      tmux # check diff with zellij, zellij prettier, but has too many unused space
      tabiew
      timg
      lazyssh # could be useful someday
      kew
      chafa
      kmon
      superfile # good yazi alternative (but old version), check image preview and should choose one of them as default
      bottom
      regex-tui
      fx
      nethack
      wezterm # alacritty alternative, tabs, support image rendering, but consumes more memory
      msedit # classic nonmodal editor, love it
      quadrapassel
      bandwhich
      kakoune # good alternative for nvim, need check differences to choose one of them (also helix)

      # https://github.com/rothgar/awesome-tuis
      # to experiment
      # twig               # not in pkgs, quite narrow usage
      # dashbrew           # not in pkgs
      # nerdlogs           # not in pkgs
      # ntc                # not in pkgs
      # carbonyl           # not in pkgs
      # browsh
      # astromenace
      # pond               # not in pkgs
      # tui-slides         # not in pkgs
      # doxx
      # desktop-tui        # not in pkgs
      # radiogogo          # not in pkgs
      # image-sorter       # not in pkgs, but could be very useful
      # upkgs.wifitui
      # akhq               # not in pkgs
      # diskonaut          # not in pkgs
      # cava               # maybe in future
      # termgl
      # process-compose    # could be useful for further testing
      # podman-tui         # could be useful
      # sudoku-rs          # not in pkgs
      # upkgs.sqlit-tui
      # sshtron            # not in pkgs
      # ntc                # not in pkgs
      # ls-horizons        # not in pkgs
      # stu                # tui for S3
      # lazydocker         # could be useful
      # corefreq           # not in pkgs
      # oha                # not very useful on dayly routine
      # helix              # not in pkgs
      # k9s                # if for some reason I would kubernate
      # NetHack            # not in pkgs
      # dive               # for Docker images
      # upkgs.fresh-editor
      # binsider           # insides of elf
      # far2l              # if boring
      # s3duck-tui         # not in pkgs
      # gonzo              # need logs
      # yozefu             # not in pkgs, need kafka
      # rovr               # not in pkgs

      # experiments

      # failed experiments
      # atop       # quiet loaded UI
      # cbonsai    # fun for final image, but growth
      # bastet     # not quiet useful
      # zee        # outdated version
      # wtfutil    # issues/1714
      # chawan     # does not work well in css-bloated pages
      # astroterm  # interesting app, but no idea of usage
      # slides     # not useful
      # ctune      # Failed to fetch: Curl KO / HTTP code 200
      # asak       # no sound
      # caligula   # disk burning in 2k26
      # rainfrog   # I use dbeaver btw
      # harlequin  # dbeaver
      # nudoku     # fine, but not interesting enough
      # nnn        # yazi btw
      # ninvaders  # mid
      # moon-buggy # chrome dino
      # atac       # prefer curl and postman
      # twig       # no use
      # lazysql    # dbeaver
      # play       # can test in terminal
    ]
    ++ (localUtils.fromFileYAML {
      inherit pkgs;
      file = ./packages.yaml;
    }).uncategorized;
}
