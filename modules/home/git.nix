{ ... }: {
  programs.git = {
    enable = true;

    userName = "local-administrator";
    # Email is set in ~/.gitconfig.local (device-specific, not tracked in version control)

    signing = {
      # SSH signing key — set in ~/.gitconfig.local (device-specific)
      # signingKey = "ssh-ed25519 ...";
      signByDefault = true;
    };

    extraConfig = {
      # ── Signing ─────────────────────────────────────────────────────────
      gpg.format = "ssh";
      "gpg \"ssh\"" = {
        program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        allowedSignersFile = "~/.config/git/allowed_signers";
      };
      commit.verbose = true;

      # ── Repository Defaults ─────────────────────────────────────────────
      init.defaultBranch = "main";
      core = {
        excludesfile = "~/.gitignore";
        fsmonitor = true;
        untrackedCache = true;
      };

      # ── Display & UI ────────────────────────────────────────────────────
      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      help.autocorrect = "prompt";
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      # ── Remote Operations ───────────────────────────────────────────────
      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      pull.rebase = true;

      # ── History Management ──────────────────────────────────────────────
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      credential.helper = "cache";

      # ── LFS ─────────────────────────────────────────────────────────────
      "filter \"lfs\"" = {
        clean    = "git-lfs clean -- %f";
        smudge   = "git-lfs smudge -- %f";
        process  = "git-lfs filter-process";
        required = true;
      };
    };

    # Device-specific config (email, signing key) stays out of version control
    includes = [
      { path = "~/.gitconfig.local"; }
    ];
  };
}
