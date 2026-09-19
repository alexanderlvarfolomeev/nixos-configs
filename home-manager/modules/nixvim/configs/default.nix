{config, ...}: {
  colorschemes.gruvbox.enable = true;

  plugins = {
    bufferline.enable = true;
    web-devicons.enable = true;
    lualine.enable = true;

    telescope.enable = true;
    oil.enable = true;
    treesitter = {
      enable = true;
      grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
        bash
        json
        lua
        nix
        python
        rust
        sql
        toml
        vim
        yaml
      ];
    };
    luasnip.enable = true;

    lsp = {
      enable = true;
      servers = {
        lua_ls.enable = true;
        nixd.enable = true;
        jsonls.enable = true;
        yamlls.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
      };
    };

    cmp = {
      enable = true;
      settings = {
        autoEnableSources = true;
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
        ];
      };
    };

    none-ls = {
      enable = true;
      sources.formatting = {
        alejandra.enable = true;
        prettier.enable = true;
        stylua.enable = true;
        yamlfmt.enable = true;
      };
    };

    conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lsp_fallback = "fallback";
          timeout_ms = 500;
        };
        notify_on_error = true;
        formatters_by_ft = {
          json = ["prettier"];
          lua = ["stylua"];
          nix = ["alejandra"];
          yaml = ["yamlfmt"];
        };
      };
    };
  };

  imports = [./bindings.nix];
}
