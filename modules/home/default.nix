{ ... }: {
  imports = [
    ./shell.nix
    ./git.nix
    ./tools.nix
    ./neovim.nix
    ./packages.nix
  ];

  # Home Manager state version — do not change after initial install
  home.stateVersion = "24.11";
}
