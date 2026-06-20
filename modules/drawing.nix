{ config, pkgs, lib, ... }:
let
  cfg = config.myModules.drawing;
in {
  options.myModules.drawing = {
    enable = lib.mkEnableOption "Enable drawing things";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      krita
    ];
    
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };

    hardware.uinput.enable = true;
    boot.kernelModules = [ "uinput" ];
  };
}
