# nixfiles

Declarative macOS configuration using nix-darwin + Home Manager + Flakes.

A single command provisions a new machine — no manual steps, no drift.

## 🚀 Quick Start

```bash
# Install Nix (Determinate Systems installer)
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Clone and apply
git clone https://github.com/local-administrator/nixfiles ~/.nixfiles
cd ~/.nixfiles
nix run nix-darwin -- switch --flake .#macbook
```

After the first switch, subsequent updates use:

```bash
darwin-rebuild switch --flake .#macbook
```

## 📦 Components

### Layers

| Layer | Responsibility |
|---|---|
| **nix-darwin** | macOS system defaults, system packages, Homebrew management |
| **Home Manager** | User config (shell, git, tools, dotfiles) |
| **Homebrew** (via nix-darwin) | GUI casks (1Password, Ghostty, Zed, etc.) |
| **Flakes** | Reproducible, pinned dependency versions |

### Terminal

#### Fish Shell
- Vi key bindings
- Aliases: `cat` → `bat`, `ls` → `lsd`, `vim` → `nvim`, `lg` → `lazygit`, `g` → `git`
- Abbreviation: `rm` → `trash`
- Plugins (managed by Home Manager, sourced from nixpkgs):
  - **[fzf.fish](https://github.com/patrickf1/fzf.fish)** — Fuzzy finder integration
  - **[sponge](https://github.com/meaningful-ooo/sponge)** — Clean command history
  - **[autopair](https://github.com/jorgebucaran/autopair.fish)** — Auto-complete pairs
  - **[z](https://github.com/jethrokuan/z)** — Directory jumping
  - **[puffer-fish](https://github.com/nickeb96/puffer-fish)** — Text expansions

#### Starship Prompt
- Theme: Gruvbox Dark
- Git branch, status, and metrics
- Language version indicators (Ruby, Python, Go, Rust, etc.)
- Time display and directory truncation

### Tools

| Tool | Purpose |
|---|---|
| `bat` | `cat` replacement with syntax highlighting (Gruvbox Dark) |
| `lsd` | Modern `ls` replacement with icons |
| `fd` | Fast `find` alternative |
| `ripgrep` | Fast `grep` alternative |
| `fzf` | Fuzzy finder |
| `zoxide` | Smarter `cd` |
| `lazygit` | Terminal UI for Git |
| `gh` | GitHub CLI |
| `delta` | Better git diffs |
| `trash` | Safe `rm` (moves to Trash) |
| `tmux` | Terminal multiplexer |

### Neovim
- Package managed by Home Manager
- Config directory (`config/nvim/`) symlinked so LazyVim can write its lock file and cache

### Git
- SSH commit signing via 1Password
- Device-specific email and signing key stay in `~/.gitconfig.local` (not tracked)

### macOS Defaults
Replaces `macos_setup.sh`:
- Finder: list view, show hidden files, path bar, search current folder
- Keyboard: fast key repeat, no press-and-hold, no autocorrect/smart quotes
- Dock: bottom, size 52, no bouncing, fast autohide, scale minimize effect

### Applications (Homebrew Casks)
1Password, Anki, Elgato Control Center, Firefox, Ghostty, Google Chrome,
Logi Options+, Obsidian, Postman, ProtonVPN, Raycast, Roon, Sublime Text,
Transmit, Zed

### Fonts
- Hack Nerd Font
- JetBrains Mono
- JetBrains Mono Nerd Font

## 🗂 Structure

```
flake.nix                   # Entry point
hosts/macbook/default.nix   # Machine-specific settings
modules/darwin/
  defaults.nix              # system.defaults (macOS preferences)
  homebrew.nix              # GUI casks via nix-darwin homebrew module
  packages.nix              # System-level packages
modules/home/
  shell.nix                 # Fish config, aliases, functions, plugins
  git.nix                   # Git config (programs.git)
  tools.nix                 # bat, fzf, starship, zoxide
  neovim.nix                # Neovim package + config symlink
  packages.nix              # User-level CLI tools + runtime baselines
config/
  starship.toml             # Starship prompt config
  nvim/                     # LazyVim config
```

## 🔄 Maintenance

The `update` fish function handles everything:

```bash
update
```

This runs `nix flake update` + `darwin-rebuild switch`, Homebrew upgrades, and checks for macOS system updates.

### Per-project Environments

For pinned runtime versions in a project, use a `flake.nix` devShell:

```bash
nix develop  # enters the project's pinned environment
```
