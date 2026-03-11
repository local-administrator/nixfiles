{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    # Environment variables set on shell init
    shellInit = ''
      # Initialize Homebrew environment
      /opt/homebrew/bin/brew shellenv | source

      # Default programs
      set -gx EDITOR nvim
      set -gx VISUAL nvim
      set -gx PAGER less
      set -gx MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
      set -x LESSHISTFILE /dev/null

      # Vi key bindings
      set -U fish_key_bindings fish_vi_key_bindings

      # Dev tools (only load if present — not tracked here)
      if test -f /opt/dev/dev.fish
          source /opt/dev/dev.fish
      end
    '';

    # Shell aliases (implemented as functions to support argv pass-through)
    shellAliases = {
      cat = "bat --pager=never";
      ls  = "lsd --group-dirs first";
      vim = "nvim";
      ll  = "lsd --group-dirs first -l";
      la  = "lsd --group-dirs first -la";
      l   = "lsd --group-dirs first -l";
      lg  = "lazygit";
      g   = "git";
    };

    # Abbreviations (expand in-place as you type)
    shellAbbrs = {
      rm = "trash";
    };

    # Named functions
    functions = {
      update = {
        description = "Update all package managers and tools";
        body = ''
          set_color green
          echo '🔄 Starting system update...'
          set_color normal

          # Homebrew
          if type -q brew
              set_color blue
              echo '📦 Updating Homebrew...'
              set_color normal
              brew update
              brew upgrade
              brew cleanup
          end

          # Nix / nix-darwin
          if type -q darwin-rebuild
              set_color blue
              echo '❄️  Updating Nix flake...'
              set_color normal
              set -l prev_dir (pwd)
              cd ~/.nixfiles
              nix flake update
              darwin-rebuild switch --flake .#macbook
              cd $prev_dir
          end

          # Fisher (fish plugin manager — only if still used alongside Nix)
          if type -q fisher
              set_color blue
              echo '🐠 Updating Fish plugins...'
              set_color normal
              fisher update
              fish_update_completions
          end

          # macOS system updates
          if test (uname) = Darwin
              set_color blue
              echo '💻 Checking macOS updates...'
              set_color normal
              softwareupdate --list
              set_color yellow
              echo "💡 Run 'sudo softwareupdate -ia' to install macOS updates"
              set_color normal
          end

          set_color green
          echo '✅ Update complete!'
          set_color normal
        '';
      };
    };

    # Plugins — all available in nixpkgs fishPlugins
    plugins = [
      { name = "fzf-fish";    src = pkgs.fishPlugins.fzf-fish.src; }
      { name = "sponge";      src = pkgs.fishPlugins.sponge.src; }
      { name = "autopair";    src = pkgs.fishPlugins.autopair.src; }
      { name = "z";           src = pkgs.fishPlugins.z.src; }
      { name = "puffer-fish"; src = pkgs.fishPlugins.puffer-fish.src; }
    ];
  };
}
