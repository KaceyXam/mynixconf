{ config, lib, pkgs, ... }:
let
  cfg = config.myModules.wm;
  dotfiles = ../dotfiles;
  username = "kxkniffen";

  powermenu = pkgs.writeShellApplication {
    name = "powermenu";
    runtimeInputs = with pkgs; [ fuzzel sway ];
    text = ''
      entries="Lock\nLogout\nSuspend\nReboot\nShutdown"

      selected=$(echo -e "$entries" | fuzzel --dmenu --prompt "Power: ")

      case "$selected" in
        Lock) swaylock ;;
        Logout) swaymsg exit ;;
        Suspend) systemctl suspend ;;
        Reboot) systemctl reboot ;;
        Shutdown) systemctl poweroff ;;
      esac
    '';
  };
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
      powermenu

      grim
      slurp
      sway-contrib.grimshot
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
