{upkgs, ...}: {
  networking.hostName = "nixos"; # Define your hostname.

  networking.wireless.iwd = {
    enable = true;
    settings = {
      IPv6 = {
        Enabled = true;
      };
      Settings = {
        AutoConnect = true;
      };
    };
  };

  # Optional, but otherwise require opening ports for  apps like localsend
  networking.firewall.enable = false;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  /*
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.networkmanager.dhcp = "dhcpcd";
  networking.dhcpcd.enable = true;
  networking.useDHCP = lib.mkForce true;
  systemd.services.dhcpcd.enable = false;
  networking.wireless.userControlled.enable = true;
  */
  /*
  services.connman.wifi.backend = "iwd";
  */

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  programs.amnezia-vpn = {
    enable = true;
    package = upkgs.amnezia-vpn;
  };
}
