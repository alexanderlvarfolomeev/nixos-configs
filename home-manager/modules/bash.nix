{user, ...}: {
  programs.bash = {
    enable = true;
    shellAliases = {
      switch = "nh os switch";
      hmswitch = "nh home switch";
    };
    bashrcExtra = ''
      if command -v fzf-share >/dev/null; then
        source "$(fzf-share)/key-bindings.bash"
        source "$(fzf-share)/completion.bash"
      fi
    '';
    #    initExtra = ''
    #      if uwsm check may-start; then
    #        exec uwsm start hyprland-uwsm.desktop
    #      fi
    #    '';
  };
}
