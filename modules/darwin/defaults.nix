{ ... }: {
  system.defaults = {
    # ── Finder ──────────────────────────────────────────────────────────────
    finder = {
      FXPreferredViewStyle = "Nlsv";          # List view by default
      ShowPathbar = true;
      AppleShowAllFiles = true;               # Show hidden files
      FXEnableExtensionChangeWarning = false;
      NewWindowTarget = "PfLo";              # Home folder for new windows
      FXDefaultSearchScope = "SCcf";         # Search current folder
      _FXShowPosixPathInTitle = true;
    };

    # ── Keyboard & Mouse ────────────────────────────────────────────────────
    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      ApplePressAndHoldEnabled = false;
      "com.apple.swipescrolldirection" = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      AppleKeyboardUIMode = 3;               # Full keyboard access in dialogs
      NSNavPanelExpandedStateForSaveMode = true;
      PMPrintingExpandedStateForPrint = true;
      AppleHighlightColor = "1.000000 0.749020 0.823529 Pink";
    };

    # ── Dock ────────────────────────────────────────────────────────────────
    dock = {
      orientation = "bottom";
      tilesize = 52;
      show-recents = false;
      showhidden = true;
      "no-bouncing" = true;
      mineffect = "scale";
      autohide-time-modifier = 0.25;
      show-process-indicators = true;
    };

    # ── Activity Monitor ────────────────────────────────────────────────────
    ActivityMonitor = {
      SortColumn = "CPUUsage";
      SortDirection = 0;
    };
  };

  # ── Settings not supported by nix-darwin system.defaults ────────────────
  # Applied via activationScripts which run on every darwin-rebuild switch
  system.activationScripts.extraDefaults.text = ''
    echo "Applying extra macOS defaults..."

    # Alert sound: Tink (clear and short)
    defaults write -g com.apple.sound.beep.sound /System/Library/Sounds/Tink.aiff

    # Disable crash reporter dialog
    defaults write com.apple.CrashReporter DialogType -string none

    # Prevent Photos from opening when plugging in iPhone
    defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

    # Auto-quit printer app when jobs complete
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
  '';
}
