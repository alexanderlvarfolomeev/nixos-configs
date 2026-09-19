{
  lib,
  pkgs,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "lua" "qml"];
    userSettings = {
      buffer_font_family = lib.mkForce "JetBrainsMono Nerd Font";
      buffer_font_size = lib.mkForce 18;

      ui_font_family = lib.mkForce "Noto Sans";
      ui_font_size = lib.mkForce 17;

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

        Lua = {
          format_on_save = "on";
          formatter = {
            external = {
              command = "stylua"; # Ensure stylua is in your home.packages
              arguments = ["--search-parent-directories" "-"];
            };
          };
        };

        QML = {
          language_servers = ["qml" "qmljs"];
        };
      };

      lsp = {
        nixd = {
          settings = {
            diagnostic = {
              suppress = ["sema-extra-with"];
            };
          };
        };

        lua-language-server = {
          binary = {
            path = "lua-language-server";
          };
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT"; # Target runtime environment
              };
              diagnostics = {
                globals = ["vim" "hs" "hl"]; # Stops warnings for common global environments (Neovim/Hammerspoon/Hyprland)
              };
              workspace = {
                library = [
                  "${pkgs.hyprland}/share/hypr/stubs"
                ];
                checkThirdParty = false; # Prevents annoying environment popups
              };
              telemetry = {
                enable = false; # Opt-out of analytics data
              };
            };
          };
        };

        qml = {
          binary = {
            arguments = ["-E"];
          };
        };
        qmljs = {
          binary = {
            arguments = ["-E"];
          };
        };
      };
    };
  };
}
