{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./hosts/laptop/config.nix

        home-manager.nixosModules.home-manager

        ./home.nix
      ];
    };

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./hosts/desktop/config.nix

        home-manager.nixosModules.home-manager

        ./home.nix
      ];
    };
  };
}
