{
  programs.nixvim = {
    enable = true;
    imports = [./configs];
  };
}
