{ self, inputs, ... }: {
  
  perSystem = { ... }: {
    packages.hyprlandWrapper = {
      config,
      pkgs,
      wlib,
      lib,
      ...
    }: {
      imports = [ wlib.modules.default ];
  
      options = {
        settings = lib.mkOption {
          description = ''
            Hyprland configuration settings.
          '';
          default = {};
          type = lib.types.submodule {
            freeformType = lib,types.attrs;
          }
        };
      };
    };
  };
}
