{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:duxlabs-dev/dux-shell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
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
