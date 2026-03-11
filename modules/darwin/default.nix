{ pkgs, ... }: {
  imports = [
    ./defaults.nix
    ./homebrew.nix
    ./packages.nix
  ];

  # Set fish as the default system shell
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
}
