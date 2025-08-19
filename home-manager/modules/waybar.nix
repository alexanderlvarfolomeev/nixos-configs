{
  programs.waybar = {
    enable = true;
    style = ./waybar-style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        modules-left = [
          "custom/icon"
          "group/hardware"
        ];
        modules-center = ["hyprland/workspaces"];
        modules-right = [
          "tray"
          "hyprland/language"
          "network"
          "pulseaudio"
          "battery"
          "clock"
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
          format = "";
          on-click = "wofi --show drun";
          tooltip = false;
          align = 0.5;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          show-special = true;
          special-visible-only = true;
          all-outputs = false;

          persistent-workspaces = {
            "*" = 7;
          };
        };

        /*
              "hyprland/window" = {
                max-length = 40;
                rewrite = {
        "(.*) — Mozilla Firefox" = "🌎 $1";
        "(.*) - zsh" = "> [$1]";
         };
              };
        */

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

        "hyprland/language" = {
          format-en = "🇺🇸";
          format-ru = "🇷🇺";
          min-length = 5;
          tooltip = false;
        };

        "network" = {
          format = "{ifname}";
          format-ethernet = " {ifname}";
          format-linked = "󰖪 {essid} (No IP)";
          format-wifi = "󰖩 {essid}";
          format-disconnected = " ";
          tooltip-format = "{ifname} via {gwaddr}";
          tooltip-format-ethernet = "{ifname} {ipaddr}/{cidr}";
          tooltip-format-disconnected = "Disconnected";
          max-length = 20;
          on-click = "iwgtk";
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
          on-click = "pavucontrol";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 5;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };

        "clock" = {
          format = "{:%H:%M}";
          tooltip-format = "{:%A, %B %d at %R}";
        };

        "tray" = {
          icon-size = 14;
          spacing = 1;
        };
      };
    };
  };
}
