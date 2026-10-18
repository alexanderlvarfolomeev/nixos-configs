{
  lib,
  config,
  ...
}: {
  programs.alacritty = {
    enable = true;
    # TODO: write separate config for fullscreen
    settings = {
      font.offset = {
        y = 2; # disables bottom padding in fullscreen for neo
      };
    };
  };

  # alacritty alternative, tabs, support image rendering, but consumes more memory
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        hide_tab_bar_if_only_one_tab = true
      }
    '';
  };

  # for default hyprland config in case nix config would be bricked
  programs.kitty = {
    enable = true;
    shellIntegration.enableBashIntegration = true;
  };

  programs.foot = {
    enable = true;
    # stylix adds extra colors which break palettes in some utilities
    settings = {
      "colors-dark" = let
        colors = config.lib.stylix.colors;
      in
        lib.mkForce {
          #       alpha = config.stylix.opacity.terminal;
          #       foreground = colors.base05;
          #       background = colors.base00;
          #       regular0 = colors.base00;
          #       regular1 = colors.base08;
          #       regular2 = colors.base0B;
          #       regular3 = colors.base0A;
          #       regular4 = colors.base0D;
          #       regular5 = colors.base0E;
          #       regular6 = colors.base0C;
          #       regular7 = colors.base05;
          #       bright0 = colors.base03;
          #       bright1 = colors.base08;
          #       bright2 = colors.base0B;
          #       bright3 = colors.base0A;
          #       bright4 = colors.base0D;
          #       bright5 = colors.base0E;
          #       bright6 = colors.base0C;
          #       bright7 = colors.base07;
          "16" = colors.base00;
        };
    };
  };
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = ["foot.desktop"];
    };
  };

  # too much memory consumption
  # programs.ghostty = {
  #   enable = true;
  #   enableBashIntegration = true;
  # };
}
