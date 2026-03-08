{
  pkgs,
  # upkgs,
  lib,
  localUtils,
  ...
}: let
  extraPackagesNameList = lib.pipe ./packages.yaml [
    (localUtils.fromFileYAML pkgs)
    builtins.attrValues
    builtins.concatLists
  ];
in {
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.alacritty = {
    enable = true;
    # TODO: write separate config for fullscreen
    settings = {
      font.offset = {
        y = 2; # disables bottom padding in fullscreen for neo
      };
    };
  };

  programs.quickshell.enable = true;

  programs.vscode = {
    enable = true;
    profiles.default.userSettings = {
      "git.openRepositoryInParentFolders" = "never";
      "editor.tabSize" = 2;
    };
  };

  programs.zed-editor = {
    enable = true;
    extensions = ["nix"];
    userSettings = {
      buffer_font_family = lib.mkForce "JetBrainsMono NF";
      buffer_font_size = lib.mkForce 18;

      ui_font_family = lib.mkForce "Noto Sans";
      ui_font_size = lib.mkForce 17;

      lsp = {
        nixd = {
          settings = {
            diagnostic = {
              suppress = ["sema-extra-with"];
            };
          };
        };
      };
      languages = {
        Nix = {
          language_servers = ["nixd" "!nil"];
          formatter = {
            external = {
              command = "alejandra";
              arguments = ["--quiet" "--"];
            };
          };
        };
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  home.packages = localUtils.getPkgsByNames pkgs extraPackagesNameList;
}
