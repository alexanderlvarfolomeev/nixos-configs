{...}: {
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Has issues with it. Zed editor parses 2668 font faces for 6s instead of 1s.
  # nixpkgs.overlays = [nix-cachyos-kernel.overlays.pinned];
  # boot.kernelPackages = pkgs.linuxPackagesFor pkgs.cachyosKernels.linux-cachyos-lts-lto-x86_64-v3; # x86_64-v3 is max supported by laptop.
}
