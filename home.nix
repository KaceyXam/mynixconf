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

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          ll = "ls -la";
          update = "sudo nixos-rebuild switch";
        };

        history = {
          size = 10000;
          path = "$HOME/.zsh_history";
          ignoreAllDups = true;
        };
      };

      programs.starship = {
        enable = true;
        settings = {
          format = "$directory $git_branch $git_state $line_break $character";
          add_newline = true;
          directory = {
            style = "blue";
            truncation_length = 0;
          };
          character = {
            success_symbol = "[❯](purple)";
            error_symbol = "[❯](red)";
            vimcmd_symbol = "[❯](green)";
          };
          git_branch = {
            format = "[$branch]($style)";
            style = "bright-black";
          };
          git_state = {
            format = "\([$state( $progress_current/$progress_total)]($style)\)";
            style = "bright-black";
          };
        };
      };
    };
  };
}
