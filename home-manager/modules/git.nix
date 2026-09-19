{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.git.override {withLibsecret = true;};
    settings = {
      user = {
        name = "alexanderlvarfolomeev";
        email = "vas.aleks.v@gmail.com";
      };
      credential.helper = "{config.programs.git.package}/bin/git-credential-libsecret";
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
