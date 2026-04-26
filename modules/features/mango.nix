{ self, inputs, ... }: {
  flake.nixosModules.mangowm = { pkgs, lib, ... }:
  let
    
  in
  {
    programs.mango.enable = true;
  };
}
