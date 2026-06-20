{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    firefox
    novelwriter
    obsidian
    tidal-hifi

    git
    helix
    ripgrep
    vlc

    enchant
    python312Packages.pyenchant
    hunspell
    hunspellDicts.en_US

    kitty
    alacritty

    libnotify
    
    networkmanagerapplet

    brightnessctl
    iwd

    zip
    unzip
  ];

  fonts.packages = with pkgs; [
    ubuntu-sans

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    source-code-pro

    nerd-fonts.jetbrains-mono
  ];

  programs.git.enable = true;
}
