{ self, inputs, ... }: {
  flake.nixosModules.hyprland = { pkgs, lib, ... }: {
    programs.hyprland = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myHyprland;
    };
  };
  
  perSystem = { pkgs, lib, self', ... }: {
    packages.myHyprland = inputs.wrapper-modules.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.hyprland;
    };
  };
}
