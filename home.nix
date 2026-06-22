{ ... }:
let
  qtEnv = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    overwriteBackup = true;
    backupFileExtension = "bak";

    users.kxkniffen = {
      home.username = "kxkniffen";
      home.homeDirectory = "/home/kxkniffen";

      home.stateVersion = "24.11";

      home.sessionVariables = qtEnv;
      systemd.user.sessionVariables = qtEnv;
    };
  };
}
