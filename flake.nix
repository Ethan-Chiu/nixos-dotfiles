{

  description = "Ethan's NixOS setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/nixos/configuration.nix ];
      };
    };
    homeConfigurations = {
      ethan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home-manager/home.nix ];
      };
    };
  };

}

