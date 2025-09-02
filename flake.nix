{
  description = "Ethan's NixOS setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Helix editor
    helix.url = "github:helix-editor/helix/master";
    helix.inputs.nixpkgs.follows = "nixpkgs";

    # Zen
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # Niri compositor
    niri.url = "github:sodiboo/niri-flake/main";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    swww.url = "github:LGFae/swww";

    yazi.url = "github:sxyazi/yazi";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nixos-hardware, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

    nixosModules.nordvpn = import ./modules/nordvpn.nix;

    nixosConfigurations = {
      nixosmac = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; nordvpnModule = self.nixosModules.nordvpn; };
        modules = [
          ./hosts/nixosmac/configuration.nix
          nixos-hardware.nixosModules.apple-t2
       	] ++ [
          ./hosts/shared/nix.nix
          ./hosts/shared/niri.nix
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
        extraSpecialArgs = {
          inherit inputs;
          inherit system;
        };
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}

