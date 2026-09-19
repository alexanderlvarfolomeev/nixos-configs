{
  system,
  inputs,
  ...
}: {
  # Almost useless without premium
  home.packages = [
    inputs.fastpotify.packages.${system}.default
  ];
}
