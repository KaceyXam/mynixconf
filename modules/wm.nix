{ config, lib, pkgs, ... }:
let
  cfg = config.myModules.wm;
  dotfiles = ../dotfiles;
in {
  options.myModules.wm = {
    swayfx.enable = lib.mkEnableOption "Enable SwayFX Desktop Environment";
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
    ];

    environment.etc = {
      "xdg/waybar".source = "${dotfiles}/waybar";
      "xdg/mako".source = "${dotfiles}/mako";
      "xdg/fuzzel".source = "${dotfiles}/fuzzel";
      "xdg/sway".source = "${dotfiles}/sway";
    };
  };
}
