{ self, inputs, ... }: {
  flake.nixosModules.hyprland = { pkgs, lib, ... }: {
    programs.hyprland = {
      enable = true;
    };

    home.programs.hyprland.enable = true;
    home.programs.hyprland.settings = {};
  };
}
