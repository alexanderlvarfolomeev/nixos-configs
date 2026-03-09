{
  programs.alacritty = {
    enable = true;
    # TODO: write separate config for fullscreen
    settings = {
      font.offset = {
        y = 2; # disables bottom padding in fullscreen for neo
      };
    };
  };
}
