{moduleWithSystem, ...}: {
  flake.nixosModules.network = moduleWithSystem ({upkgs, ...}: {
    networking.wireless.iwd = {
      enable = true;
      settings = {
        IPv6.Enabled = true;
        Settings.AutoConnect = true;
      };
    };

    networking.firewall.enable = false;

    programs.amnezia-vpn = {
      enable = true;
      package = upkgs.amnezia-vpn;
    };
  });
}
