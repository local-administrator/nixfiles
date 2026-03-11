{ nixfilesRoot, ... }: {
  # ── Starship prompt ──────────────────────────────────────────────────────
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    # Starship reads ~/.config/starship.toml by default; we link it below.
    # Using home.file copies the TOML into the Nix store (read-only is fine
    # for a config file), keeping it in sync with the flake.
  };

  home.file.".config/starship.toml".source = "${nixfilesRoot}/config/starship.toml";

  # ── bat (better cat) ────────────────────────────────────────────────────
  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
      style = "numbers,changes,header";
      italic-text = "always";
    };
  };

  # ── fzf ─────────────────────────────────────────────────────────────────
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  # ── zoxide (smarter cd / replaces z) ────────────────────────────────────
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
