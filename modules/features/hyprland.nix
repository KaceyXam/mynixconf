{ self, inputs, ... }: {
  flake.nixosModules.hyprland = { pkgs, lib, ... }: {
    programs.hyprland = {
      enable = true;
    };
  };

  perSystem = { pkgs, ... }: {
    packages.hyprland = inputs.wrappers.lib.wrapModule {
      inherit pkgs;
      imports = [self.nixosModules.hyprland];
    };
  }; 
}
