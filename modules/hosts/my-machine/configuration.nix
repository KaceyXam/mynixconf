{ self, inputs, ... }: {
  flake.nixosModules.myMachineConfiguration = { pkgs, lib, ... }: {
    imports = [ 
      self.nixosModules.myMachineHardware
      self.nixosModules.niri
      self.nixosModules.hyprland
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "kaceypc"; # Define your hostname.

    networking.networkmanager.enable = true;

    services.tuned.enable = true;
    services.upower.enable = true;
  
    time.timeZone = "America/Chicago";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    services.xserver.enable = true;

    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm.enable = true;

    # services.displayManager.cosmic-greeter.enable = true;
    # services.desktopManager.cosmic.enable = true;

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    services.printing.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };

    users.users.kxkniffen = {
      isNormalUser = true;
      description = "Kacey Kniffen";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        kdePackages.kate
        novelwriter
        obsidian
        tidal-hifi
      ];
    };

    programs.steam.enable = true;

    programs.firefox.enable = true;

    hardware.opentabletdriver.enable = true;

    hardware.uinput.enable = true;
    boot.kernelModules = [ "uinput" ];

    nixpkgs.config.allowUnfree = true;

    nixpkgs.config.qt5 = {
      enable = true;
      platformTheme = "qt5ct";
    };

    environment.variables.QT_QPA_PLATFORMTHEME = "qt5ct";

    home-manager.users.kxkniffen = { pkgs, ... }: {
      home.packages = [ pkgs.hello ];
      home.stateVersion = "24.11";
    };

    environment.systemPackages = with pkgs; [
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

      ubuntu-sans
      nerd-fonts.jetbrains-mono

      kitty
      alacritty

      waybar

      mako
      libnotify

      swww    

      fuzzel

      networkmanagerapplet

      brightnessctl
      iwd

      astal.hyprland
      astal.battery
      astal.mpris
      astal.network
      astal.wireplumber

      zip
      unzip

      libreoffice-qt
      hunspell
      hunspellDicts.uk_UA
      hunspellDicts.th_TH

      kdePackages.qt6ct

      quickshell
    ];

    services.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
    };

    fonts.packages = with pkgs; [
      ubuntu-sans

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      source-code-pro

      nerd-fonts.jetbrains-mono
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11"; # Did you read the comment?

  };
}
