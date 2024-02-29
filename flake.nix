{
  description = "A NixOS flake configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    # Home manager
    # home-manager.url = "github:nix-community/home-manager/master";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
    in {
    # NixOS configuration entrypoint
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/nixos/configuration.nix ];
      };
    };

    # homeConfigurations."unofficial@mfm8s" = home-manager.lib.homeManagerConfiguration {
    #   pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #   extraSpecialArgs = { inherit inputs; };
    #   modules = [ ./home-manager/home.nix ];
    # };
  };
}
