{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-old.url = "github:nixos/nixpkgs/46db2e09e1d3f113a13c0d7b81e2f221c63b8ce9";
  };

  outputs = { nixpkgs, nixpkgs-old, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs-old = import nixpkgs-old { inherit system; };
    overlays = [
      (final: prev: {
        xdg-desktop-portal-wlr = pkgs-old.xdg-desktop-portal-wlr;
      })
    ];
  in {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./hosts/laptop/config.nix

        { nixpkgs.overlays = overlays; }

        home-manager.nixosModules.home-manager

        ./home.nix
      ];
    };

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./hosts/desktop/config.nix

        { nixpkgs.overlays = overlays; }

        home-manager.nixosModules.home-manager

        ./home.nix
      ];
    };
  };
}
