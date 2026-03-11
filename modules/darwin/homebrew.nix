{ ... }: {
  homebrew = {
    enable = true;

    # Remove casks/brews no longer listed here on each switch
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    taps = [
      "homebrew/cask-fonts"
    ];

    # GUI applications + fonts (not available or better managed via Homebrew)
    casks = [
      # Applications
      "1password"
      "anki"
      "elgato-control-center"
      "firefox"
      "ghostty"
      "google-chrome"
      "logi-options+"
      "obsidian"
      "postman"
      "protonvpn"
      "raycast"
      "roon"
      "sublime-text"
      "transmit"
      "zed"
      # Fonts
      "font-hack-nerd-font"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
    ];
  };
}
