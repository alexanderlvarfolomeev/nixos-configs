{upkgs, ...}: {
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    settings = {
      program_options = {
        file_manager = "foot -e ${upkgs.yazi}/bin/yazi";
      };
    };
  };
}
