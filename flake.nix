{
  description = "Ethan's NixOS setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Helix editor
    # helix.url = "github:helix-editor/helix/master";
    # helix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs @ { self, nixpkgs, home-manager, nixos-hardware, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      nixosmac = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          nixos-hardware.nixosModules.apple-t2
	];
      };
      nixos = lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/nixos/configuration.nix ];
      };
    };
    homeConfigurations = {
      ethan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}

