{
  flake.nixosModules.user = {
    users.users.aorise = {
      isNormalUser = true;
      description = "aorise";
      extraGroups = ["networkmanager" "wheel"];
    };

    nix.settings.trusted-users = ["root" "aorise"];
    services.getty.autologinUser = "aorise";
  };
}
