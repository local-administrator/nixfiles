{ pkgs, ... }: {
  networking.hostName = "macbook";
  networking.computerName = "MacBook";

  # System state version — do not change after initial install
  system.stateVersion = 5;

  # Allow unfree packages (needed for some tools)
  nixpkgs.config.allowUnfree = true;

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # User account
  users.users.admin = {
    name = "admin";
    home = "/Users/admin";
  };
}
