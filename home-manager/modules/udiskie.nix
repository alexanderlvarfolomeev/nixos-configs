{
  pkgs,
  upkgs,
  ...
}: {
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    settings = {
      program_options = {
        file_manager = "${pkgs.alacritty}/bin/alacritty -e ${upkgs.yazi}/bin/yazi";
      };
    };
  };
}
