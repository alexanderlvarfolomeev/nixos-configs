{
  config,
  pkgs,
  utils,
  ...
}: {
  xdg.configFile."nwg-bar/bar.json".text = builtins.toJSON [
    {
      label = "Lock";
      exec = "hyprlock";
      icon = "system-lock-screen-symbolic";
    }
    {
      label = "Sleep";
      exec = "systemctl suspend && hyprlock";
      icon = "night-light-symbolic";
    }
    {
      label = "Reboot";
      exec = "systemctl reboot";
      icon = "system-reboot-symbolic";
    }
    {
      label = "Shutdown";
      exec = "systemctl poweroff";
      icon = "system-shutdown-symbolic";
    }
  ];

  # Power profile choose
  # xdg.configFile."nwg-bar/power.json".text = builtins.toJSON [
  #   {
  #     label = "Performance";
  #     exec = "powerprofilesctl set performance";
  #     icon = "power-profile-performance-symbolic";
  #   }
  #   {
  #     label = "Balanced";
  #     exec = "powerprofilesctl set balanced";
  #     icon = "power-profile-balanced-symbolic";
  #   }
  #   {
  #     label = "Power Saver";
  #     exec = "powerprofilesctl set power-saver";
  #     icon = "power-profile-power-saver-symbolic";
  #   }
  # ];

  xdg.configFile."nwg-bar/style.css".text = ''
    * {
      font-family: "JetBrainsMono NF";
    }

    window {
      background-color: transparent;
    }

    /* Outer bar container, takes all the window width/height */
    #outer-box {
    	margin: 0px;
        border-radius: 10px;
        border: 1px solid #48cae4;
    }

    /* Inner bar container, surrounds buttons */
    #inner-box {
    	background-color: alpha(#1d2021, 0.95);
    	border-radius: 10px;
    	border-style: none;
    	border-width: 1px;
    	border-color: alpha(#48cae4, 0.7);
    	padding: 5px;
    }

    image {
    	background: none;
    	border: none;
    	box-shadow: none;
        margin-bottom: 5px;
    }

    button {
      background: none;
    	padding-left: 10px;
    	padding-right: 10px;
    	border-style: solid;
    	border-width: 2px;
    	border-color: transparent;
    	margin: 5px;
        color: #48cae4;
    }

    button:hover {
    	background-color: #003b5b;
    }

  '';
}
