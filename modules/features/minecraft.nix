{ self, inputs, ... }: {
  flake.nixosModules.minecraftServer = { pkgs, lib, ... }: {
    services.minecraft-server = {
      enable = true;
      eula = true;
      openFirewall = true;
      declarative = true;
      
      # package = pkgs.papermc;

      serverProperties = {
        port = 25566;
        gamemode = "survival";
        difficulty = "normal";
        simulation-distance = 8;
      };
    };
  };
}
