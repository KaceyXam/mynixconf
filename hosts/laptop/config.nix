{ config, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ../../modules/gaming.nix
    ../../modules/wm.nix
    ../../modules/drawing.nix
  ];

  myModules.wm.swayfx.enable = true;
  myModules.drawing.enable = true;
  myModules.gaming.enable = true;

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

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.qt5 = {
    enable = true;
    platformTheme = "qt5ct";
  };

  environment.variables.QT_QPA_PLATFORMTHEME = "qt5ct";

  
  users.users.kxkniffen = {
    isNormalUser = true;
    description = "Kacey Kniffen";
    extraGroups = [ "networkmanager" "wheel" ];
  };

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
}
