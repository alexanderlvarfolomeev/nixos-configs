{lib, ...}: {
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
        # qml = {
        #   binary = {
        #     arguments = ["-E" "additional-args"];
        #   };
        # };
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
}
