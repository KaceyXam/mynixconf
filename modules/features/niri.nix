{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };
  
  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings =
      let
        noctaliaExe = lib.getExe self'.packages.myNoctalia;
      in {
        prefer-no-csd = null;
        animations = null;
        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

        layout = {
          gaps = 8;
          center-focused-column = "on-overflow";
          preset-column-widths = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
          ];
          default-column-width = { proportion = 0.5; };

          focus-ring = {
            width = 2;
          };
        };

        layer-rules = [
          {
            matches = [
              {
                namespace = "^noctalia-overview*";
              }
            ];
            place-within-backdrop = true;
          }
        ];

        window-rules = [
          {
            geometry-corner-radius = 6;
            clip-to-geometry = true;
          }
        ];
        
        spawn-at-startup = [
           (noctaliaExe) 
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input = {
          keyboard.xkb.layout = "us,ua";
          touchpad = {
            tap = null;
            natural-scroll = null;
          };
        };

        binds = {
          "Mod+Shift+Slash".show-hotkey-overlay = null;
          
          "Mod+Return".spawn-sh = lib.getExe pkgs.alacritty;
          "Mod+Space".spawn-sh = "${noctaliaExe} ipc call launcher toggle";
          "Mod+Shift+L".spawn-sh = "${noctaliaExe} ipc call lockScreen lock";

          "Mod+O".toggle-overview = null;
          "Mod+Q".close-window = null;

          "XF86AudioRaiseVolume" = { spawn-sh = "${noctaliaExe} ipc call volume increase"; };
          "XF86AudioLowerVolume" = { spawn-sh = "${noctaliaExe} ipc call volume decrease"; };
          "XF86AudioMute" = { spawn-sh = "${noctaliaExe} ipc call volume muteOutput"; };
          "XF86AudioMicMute" = { spawn-sh = "${noctaliaExe} ipc call volume muteInput"; };

          "XF86AudioPlay" = { spawn-sh = "${noctaliaExe} ipc call media playPause"; };
          "XF86AudioStop" = { spawn-sh = "${noctaliaExe} ipc call media stop"; };
          "XF86AudioPrev" = { spawn-sh = "${noctaliaExe} ipc call media previous"; };
          "XF86AudioNext" = { spawn-sh = "${noctaliaExe} ipc call media next"; };

          "XF86MonBrightnessUp" = { spawn-sh = "${noctaliaExe} ipc call brightness increase"; };
          "XF86MonBrightnessDown" = { spawn-sh = "${noctaliaExe} ipc call brightness decrease"; };

          "Mod+Left".focus-column-left = null; 
          "Mod+Down".focus-window-down = null; 
          "Mod+Up".focus-window-up = null; 
          "Mod+Right".focus-column-right = null; 

          "Mod+Ctrl+Left".move-column-left = null;
          "Mod+Ctrl+Down".move-window-down = null;
          "Mod+Ctrl+Up".move-window-up = null;
          "Mod+Ctrl+Right".move-column-right = null;

          "Mod+U".focus-workspace-down = null;
          "Mod+I".focus-workspace-up = null;

          "Mod+Ctrl+U".move-column-to-workspace-down = null;
          "Mod+Ctrl+I".move-column-to-workspace-up = null;

          "Mod+Shift+U".move-workspace-down = null;
          "Mod+Shift+I".move-workspace-up = null;


          "Mod+BracketLeft".consume-or-expel-window-left = null;
          "Mod+BracketRight".consume-or-expel-window-right = null;

          "Mod+Comma".consume-window-into-column = null;
          "Mod+Period".expel-window-from-column = null;

          "Mod+R".switch-preset-column-width = null;
          "Mod+Shift+R".switch-preset-column-width-back = null;

          "Mod+Ctrl+Shift+R".switch-preset-window-height = null;
          "Mod+Ctrl+R".reset-window-height = null;

          "Mod+F".maximize-column = null;
          "Mod+Shift+F".fullscreen-window = null;

          # "Mod+Minus".set-column-width = "-10%";
          # "Mod+Plus".set-column-width = "+10%";
          # "Mod+Shift+Minus".set-column-height = "-10%";
          # "Mod+Shift+Plus".set-column-height = "+10%";
          
          "Mod+V".toggle-window-floating = null;
          "Mod+Shift+V".switch-focus-between-floating-and-tiling = null;
          
          "Mod+W".toggle-column-tabbed-display = null;

          "Print".screenshot = null;
          "Ctrl+Print".screenshot-screen = null;
          "Alt+Print".screenshot-window = null;

          "Mod+E".spawn-sh = "${noctaliaExe} ipc call sessionMenu toggle";
        };
      };
    };
  };
}
