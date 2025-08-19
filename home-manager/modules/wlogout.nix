{ config, pkgs, utils, ... }: {
  xdg.configFile."wlogout/layout".text = builtins.toJSON {
      label = "lock";
      text = "Lock";
      action = "sleep 0.5 && hyprlock";
      keybind = "l";
      /* icon = "system-lock-screen-symbolic"; */
    } + builtins.toJSON {
      label = "suspend";
      text = "Sleep";
      action = "sleep 0.5 && systemctl suspend";
      keybind = "e";
      /* icon = "night-light-symbolic"; */
    } + builtins.toJSON {
      label = "reboot";
      text = "Restart";
      action = "~/.local/scripts/power.sh reboot";
      keybind = "r";
      /* icon = "system-reboot-symbolic"; */
    } + builtins.toJSON {
      label = "shutdown";
      text = "Shutdown";
      action = "~/.local/scripts/power.sh poweroff";
      keybind = "s";
      /* icon = "system-shutdown-symbolic"; */
    };

  xdg.configFile."wlogout/icons".source = ./icons;

  xdg.configFile."wlogout/colors.css".source = ./wlogout-colors.css;
  xdg.configFile."wlogout/style.css".source = ./wlogout-style.css;
}
