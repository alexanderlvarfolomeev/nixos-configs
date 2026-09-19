{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./main.conf;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      {
        plugin = catppuccin;
        extraConfig = builtins.readFile ./catppuccin_preconfig.conf;
      }
      {
        plugin = battery;
        extraConfig = builtins.readFile ./catppuccin_postconfig.conf;
      }
      cpu
    ];
  };
}
