{ pkgs, ... }: {
  # System-level packages available to all users
  environment.systemPackages = with pkgs; [
    curl
    git
    vim  # Fallback editor before neovim is configured
  ];
}
