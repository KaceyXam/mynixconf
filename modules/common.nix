{ config, pkgs, ... }:
let
  dotfiles = ../dotfiles;
  username = "kxkniffen";
in {
  environment.systemPackages = with pkgs; [
    firefox
    novelwriter
    obsidian
    tidal-hifi
    pavucontrol

    adwaita-icon-theme

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

    qt6Packages.qt6ct
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

  programs.zsh = {
    enable = true;
  };
  users.defaultUserShell = pkgs.zsh;

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "breeze";
  };

  environment.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
  };

  home-manager.users.${username} = {
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    xdg.configFile = {
      "helix".source = "${dotfiles}/helix";
      "alacritty".source = "${dotfiles}/alacritty";
    };
  };

  programs.git.enable = true;
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
}
