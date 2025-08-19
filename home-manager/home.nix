{ config, pkgs, lib, localUtils, osVersion, user, ... }: {
    home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = osVersion;
    };

    imports = localUtils.dirImports { inherit lib; dir = ./modules; };
}
