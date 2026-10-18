{
  osVersion,
  user,
  ...
}: {
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = osVersion;
  };
}
