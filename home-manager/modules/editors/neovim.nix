{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      lua-language-server
      nixd
      vimPlugins.nvim-treesitter-parsers.hyprlang
    ];
    extraConfig = ''
      set number relativenumber
      set clipboard+=unnamedplus
    '';
  };
}
