{ config, lib, pkgs, ... }:
let
  cfg = config.myModules.wm;
  dotfiles = ../dotfiles;
  username = "kxkniffen";
in {
  options.myModules.wm = {
    swayfx = {
      enable = lib.mkEnableOption "Enable SwayFX Desktop Environment";
      monitorConfig = lib.mkOption {
        type = lib.types.path;
        description = "Path to host-specific monitor settings";
      };
    };
  };

  config = lib.mkIf cfg.swayfx.enable {
    programs.sway = {
      enable = true;
      package = pkgs.swayfx;
    };
    programs.gtklock.enable = true;
    
    environment.systemPackages = with pkgs; [
      waybar
      mako
      fuzzel
      autotiling
      swaylock-effects
    ];

    home-manager.users.${username} = {
      xdg.configFile = {
        "waybar".source = "${dotfiles}/waybar";
        "mako".source = "${dotfiles}/mako";
        "fuzzel".source = "${dotfiles}/fuzzel";
        "sway".source = "${dotfiles}/sway";
        "swaylock".source = "${dotfiles}/swaylock";
        "sway-monitors.conf".source = cfg.swayfx.monitorConfig;
      };

      home.stateVersion = "24.11";
    };
  };
}
