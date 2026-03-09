{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "alexanderlvarfolomeev";
        email = "vas.aleks.v@gmail.com";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        pagers = [
          {
            pager = "delta --dark --paging=never --line-numbers";
            colorArg = "always";
          }
        ];
      };
    };
  };
}
