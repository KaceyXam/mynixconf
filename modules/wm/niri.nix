
{ config, lib, pkgs, ... }:
let
  cfg = config.myModules.wm;
  dotfiles = ../../dotfiles;
  username = "kxkniffen";

  powermenu = pkgs.writeShellApplication {
    name = "powermenu-niri";
    runtimeInputs = with pkgs; [ fuzzel niri ];
    text = ''
      entries="Lock\nLogout\nSuspend\nReboot\nShutdown"

      selected=$(echo -e "$entries" | fuzzel --dmenu --prompt "Power: ")

      case "$selected" in
        Lock) swaylock ;;
        Logout) niri msg action quit ;;
        Suspend) systemctl suspend ;;
        Reboot) systemctl reboot ;;
        Shutdown) systemctl poweroff ;;
      esac
    '';
  };

  application-switcher = pkgs.writeShellApplication {
    name = "application-switcher";
    runtimeInputs = with pkgs; [ fuzzel niri jq ];
    text = ''
      windows=$(niri msg -j windows)

      selected=$(
        echo "$windows" |
          jq -r '.[] | "\(.id)\t\(.app_id)\t\(.title // "")"' |
          fuzzel --dmenu --with-nth=2,3 --accept-nth=1
      )

      [ -z "$selected" ] && exit 0

      id=$(printf '%s' "$selected" | cut -f1)

      niri msg action focus-window --id "$id"
    '';
  };
in {
  options.myModules.wm = {
    niri = {
      enable = lib.mkEnableOption "Enable Niri Window Manager";
      monitorConfig = lib.mkOption {
        type = lib.types.path;
        description = "Path to host-specific monitor settings";
      };
    };
  };

  config = lib.mkIf cfg.niri.enable {
    programs.niri = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      waybar
      mako
      fuzzel
      swaylock-effects
      powermenu
      awww
      application-switcher
      xwayland-satellite
      kanshi
    ];
    
    home-manager.users.${username} = {
      xdg.configFile = {
        "waybar/config-niri.jsonc".source = "${dotfiles}/waybar/config-niri.jsonc";
        "waybar/style.css".source = "${dotfiles}/waybar/style.css";
        "niri/config.kdl".source = "${dotfiles}/niri/config.kdl";
        "niri/monitors.kdl".source = cfg.niri.monitorConfig;
        "mako".source = "${dotfiles}/mako";
        "fuzzel".source = "${dotfiles}/fuzzel";
        "swaylock".source = "${dotfiles}/swaylock";
        "kanshi/config".source = "${dotfiles}/kanshi/config";
      };

      home.stateVersion = "24.11";
    };
  };
}
