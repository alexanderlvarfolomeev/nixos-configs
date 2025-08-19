{user, ...}: {
  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/${user}/nix";
      hmswitch = "home-manager switch --flake /home/${user}/nix";
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
