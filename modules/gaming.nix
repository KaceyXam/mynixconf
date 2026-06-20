{ config, lib, ... }:
let
  cfg = config.myModules.gaming;
in {
  options.myModules.gaming = {
    enable = lib.mkEnableOption "Enable gaming things";
  };

  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;
  };
}
