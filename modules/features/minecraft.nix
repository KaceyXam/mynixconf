{ self, inputs, ... }: {
  flake.nixosModules.minecraftServer = { pkgs, lib, ... }: {
    imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
    nixpkgs.overlays =  [ inputs.nix-minecraft.overlay ]; 
    
    services.minecraft-servers =
    let
      modpack = pkgs.fetchModrinthModpack {
        src = ../../modpacks/Modded-Kniffen-Fam.mrpack;
        packHash = "sha256-ClHjvAA3lhTqAdgL01GMDYgCERBtDJh0EzrnEISTZ70=";
      };
    in {
      enable = true;
      eula = true;
      openFirewall = true;
      managementSystem.systemd-socket.enable = true;
      
      servers = {
        modded = {
          enable = true;
          package = pkgs.neoforgeServers.neoforge-1_21_1;

          serverProperties = {};

          symlinks = {
            "mods" = "${modpack}/mods";
          };
          # files = {
          #   "config" = "${modpack}/config";
          # };
        };
      };
    };
  };
}
