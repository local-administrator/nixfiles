{ lib, nixfilesRoot, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Symlink the LazyVim config directory rather than copying it to the Nix
  # store. LazyVim needs to write lazy-lock.json and cache files, so the
  # directory must be mutable. The activation script creates (or refreshes)
  # the symlink on every darwin-rebuild switch.
  home.activation.linkNvimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfn "${nixfilesRoot}/config/nvim" "$HOME/.config/nvim"
  '';
}
