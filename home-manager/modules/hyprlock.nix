{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };

      background = {
        path = "screenshot";
        blur_passes = 2;
        blur_size = 6;
      };

      label = {
        text = "$TIME";
        font_size = 96;
        font_family = "JetBrains Mono";
        color = "rgba(235, 219, 178, 1.0)";
        position = "0, 40%";
        halign = "center";
        valign = "center";

        shadow_passes = 1;
      };

      input-field = [
        {
          size = "300, 50";
          position = "0, -5%";
          dots_center = true;
          font_color = "rgb(235, 219, 178)";
          inner_color = "rgb(40, 40, 40)";
          outer_color = "rgb(60, 56, 54)";
          outline_thickness = 5;
          placeholder_text = "...";
          fade_on_empty = false;
          shadow_passes = 1;
        }
      ];
    };
  };
}
