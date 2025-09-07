{upkgs, ...}: {
  home.file.".config/waybar/flake.svg".source = ./nix-snowflake.svg;
  programs.waybar = {
    enable = true;
    package = upkgs.waybar;
    style = ./waybar-style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        modules-left = [
          "custom/icon"
          "clock"
          "cava"
          "mpris"
        ];
        modules-center = ["hyprland/workspaces"];
        modules-right = [
          "wlr/taskbar"
          "group/net-audio-bat"
          "group/hardware"
          "hyprland/language"
          "custom/power"
        ];

        "group/hardware" = {
          orientation = "horizontal";
          modules = [
            "disk"
            "memory"
            "cpu"
          ];
        };

        "custom/power" = {
          format = "⏻ ";
          tooltip = false;
          on-click = "wlogout -b 2";
        };

        "custom/icon" = {
          /* format = ""; */
          format = " ";
          align = 0.5;
          on-click = "rofi -show drun";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          show-special = true;
          special-visible-only = true;
          all-outputs = false;

          persistent-workspaces = {
            "*" = 5;
          };
        };

        "cpu" = {
          format = "{usage}% ";
          tooltip = true;
          tooltip-format = "Usage: {usage}%\nCores: {cores}";
        };

        "memory" = {
          format = "{}% 󰍛";
          tooltip = true;
          tooltip-format = "Usage: {used} / {total} ({percentage}%)";
        };

        "disk" = {
          format = "{percentage_free}% ";
          tooltip = true;
          tooltip-format = "Free percentage: {free} / {total} ({percentage_free}%)";
        };

        "cava" = {
          # "cava_config" = "$XDG_CONFIG_HOME/cava/cava.conf";
          "framerate" = 30;
          "autosens" = 1;
          # "sensitivity" = 100;
          "bars" = 18;
          "lower_cutoff_freq" = 50;
          "higher_cutoff_freq" = 10000;
          "hide_on_silence" = true;
          # "format_silent" = "quiet";
          "method" = "pulse";
          "source" = "auto";
          "stereo" = false;
          "reverse" = false;
          "bar_delimiter" = 0;
          "monstercat" = false;
          "waves" = false;
          "noise_reduction" = 0.77;
          "input_delay" = 2;
          "format-icons" = [" " "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          "actions" = {
            "on-click-right" = "mode";
          };
        };

        "mpris" = {
          "format" = "{player_icon} {title}";
          "format-paused" = " ";
          "tooltip-format" = "{dynamic}";
          "player-icons" = {
            "default" = "▶";
          };
          "max-length" = 40;
        };

        "hyprland/language" = {
          format-en = "🇺🇸";
          format-ru = "🇷🇺";
          min-length = 5;
          tooltip = false;
          keyboard-name = "at-translated-set-2-keyboard";
        };

        "group/net-audio-bat" = {
          orientation = "horizontal";
          modules = [
            "network"
            "pulseaudio"
            "battery"
          ];
        };

        "network" = {
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format = "{ifname}";
          format-ethernet = " {bandwidthDownOctets}";
          format-linked = "󰖪 {essid} (No IP)";
          format-wifi = "{icon}";
          format-disconnected = " ";
          tooltip-format = "{essid} ({ifname}) via {gwaddr}";
          tooltip-format-ethernet = "{ifname} {ipaddr}/{cidr}";
          tooltip-format-disconnected = "Disconnected";
          max-length = 20;
          on-click = "~/.local/scripts/toggle.sh iwgtk";
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% ";
          format-muted = "";
          format-icons = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" ""];
          };
          on-click = "~/.local/scripts/toggle.sh pavucontrol";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 5;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-icons = ["" "" "" "" ""];
        };

        "clock" = {
          format = "{:%H:%M}";
          tooltip-format = "{:%A, %B %d at %R}";
        };

        "wlr/taskbar" = {
          icon-size = 20;
          tooltip-format = "{app_id}";
          on-click = "activate";
          ignore-list = [ "Alacritty" ];
        };
      };
    };
  };
}
