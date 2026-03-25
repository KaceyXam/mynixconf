{ self, inputs, ... }: {
  flake.nixosModules.hyprland = { pkgs, lib, self', ... }: {
    programs.hyprland = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatgorm.system}.myHyprland;
    };
  };

  hyprlandWrapper = {}: {};
  
  perSystem = { pkgs, lib, self', ... }:
  let
    mod = "SUPER";
    terminal = lib.getExe pkgs.alacritty;
    noctalia = lib.getExe self'.packages.myNoctalia;
    menu = "${noctalia} ipc call launcher toggle";
  in {
    packages.myHyprland = hyprlandWrapper.wrap {
      inherit pkgs;
      "ecosystem:no_update_news" = true;
      monitor = "preferred auto auto";
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_QPA_PLATFORMTHEME_QT6,qt6ct"
      ];

      general = {
        gaps_in = 2;
        gaps_out = 2;
        border_size = 2;

        resize_on_border = true;

        allow_tearing = false;

        layout = "master";
      };

      source = [
        "noctalia-colors.conf"
      ];

      decoration = {
        rounding = 4;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 1696;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, slide "
          "workspacesIn, 1, 1.21, almostLinear, slide"
          "workspacesOut, 1, 1.94, almostLinear, slide"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = true;
        disable_hyprland_logo = false;
      };

      input = {
        kb_layout = "us";

        follow_mouse = true;

        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
        };

        bind = [
          "${mod}, RETURN, exec, ${terminal}"
          "${mod} SHIFT, Q, killactive"
          "${mod} SHIFT, M, exit"
          "${mod}, SPACE, exec, ${menu}"
          "${mod}, V, togglefloating"
          "${mod}, P, pseudo" #dwindle
          "${mod}, J, togglesplit" #dwindle
          "${mod} SHIFT, L, exec, ipc lockScreen lock"

          "${mod}, left, moveFocus, l"
          "${mod}, right, moveFocus, r"
          "${mod}, up, moveFocus, u"
          "${mod}, down, moveFocus, d"

          
          "${mod}, 1, workspace, 1"
          "${mod}, 2, workspace, 2"
          "${mod}, 3, workspace, 3"
          "${mod}, 4, workspace, 4"
          "${mod}, 5, workspace, 5"
          "${mod}, 6, workspace, 6"
          "${mod}, 7, workspace, 7"
          "${mod}, 8, workspace, 8"
          "${mod}, 9, workspace, 9"
          "${mod}, 0, workspace, 10"

          "${mod} SHIFT, 1, movetoworkspace, 1"
          "${mod} SHIFT, 2, movetoworkspace, 2"
          "${mod} SHIFT, 3, movetoworkspace, 3"
          "${mod} SHIFT, 4, movetoworkspace, 4"
          "${mod} SHIFT, 5, movetoworkspace, 5"
          "${mod} SHIFT, 6, movetoworkspace, 6"
          "${mod} SHIFT, 7, movetoworkspace, 7"
          "${mod} SHIFT, 8, movetoworkspace, 8"
          "${mod} SHIFT, 9, movetoworkspace, 9"
          "${mod} SHIFT, 0, movetoworkspace, 10"

          "${mod}, S, togglespecialworkspace, magic"
          "${mod} SHIFT, S, movetoworkspace, special:magic"


          "${mod}, mouse_down, workspace, e+1"
          "${mod}, mouse_up, workspace, e-1"
        ];
      };

      exec-once = [
        noctalia
      ];
    };
  };
}
