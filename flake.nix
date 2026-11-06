{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
  in {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      inherit system;
      inherit specialArgs;

      modules = [
        ./hosts/laptop/config.nix

        home-manager.nixosModules.home-manager

        ./home.nix
      ];
    };

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit system;
      inherit specialArgs;

      modules = [
        ./hosts/desktop/config.nix

        home-manager.nixosModules.home-manager

        ./home.nix
      ];
    };
  };
}
