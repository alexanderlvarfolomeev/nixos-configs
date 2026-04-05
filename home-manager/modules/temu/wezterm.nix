{
  # alacritty alternative, tabs, support image rendering, but consumes more memory
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        hide_tab_bar_if_only_one_tab = true
      }
    '';
  };
}
