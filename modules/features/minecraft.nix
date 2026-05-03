{ self, inputs, ... }: {
  flake.nixosModules.minecraftServer = { pkgs, lib, ... }: {
    imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
    nixpkgs.overlays =  [ inputs.nix-minecraft.overlay ]; 
    
    services.minecraft-servers = {
      enable = true;
      eula = true;
      
      servers = {
        modded = {
          enable = true;
          package = pkgs.fabricServers.fabric-1_21_11;

          serverProperties = {};

          symlinks = {
            "mods" = ../../modsList;
          };
        };
      };
    };
  };
}
