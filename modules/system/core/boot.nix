{
  flake.nixosModules.boot = {
    boot = {
      consoleLogLevel = 3;
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
