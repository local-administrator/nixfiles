{ pkgs, ... }: {
  home.packages = with pkgs; [
    # ── CLI tools ────────────────────────────────────────────────────────
    delta       # Better git diffs
    fd          # Fast find alternative
    gh          # GitHub CLI
    git-lfs     # Git Large File Storage
    lazygit     # Terminal UI for git
    lsd         # Better ls (with icons)
    nnn         # Terminal file manager
    ripgrep     # Fast grep alternative
    tmux        # Terminal multiplexer
    trash       # Safe rm (moves to Trash)
    tree-sitter # Parser generator (needed by neovim)
    wireshark   # Network analyzer (CLI tools)

    # ── Runtime baselines (replaces mise global config) ──────────────────
    # For per-project pinned versions, use flake.nix devShells in each project
    nodejs
    python3
    ruby

    # ── Note: GUI apps are managed via homebrew.nix ──────────────────────
    # ghostty, 1password, etc. are installed as Homebrew casks
  ];
}
