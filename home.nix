{ pkgs, ... }: {
  home.username = "kxkniffen";
  home.homeDirectory = "/home/kxkniffen";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    novelwriter
    obsidian
    tidal-hifi
    
    git
    helix
    emacs-pgtk
    ripgrep
    logseq
    vlc
    krita

    enchant
    python312Packages.pyenchant
    hunspell
    hunspellDicts.en_US

    kitty
    alacritty

    libnotify

    waybar
    mako
    fuzzel

    networkmanagerapplet

    brightnessctl
    iwd

    zip
    unzip

    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.th_TH

    kdePackages.qt6ct

    quickshell

    autotiling

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
