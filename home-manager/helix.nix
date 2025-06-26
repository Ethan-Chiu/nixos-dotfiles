{ inputs, pkgs, ... }:
let
  helix = inputs.helix.packages.${pkgs.system}.default;
in {
  programs.helix = {
    enable = true;
    package = helix;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # Nix
      nil
      nixd
      # HTML, CSS, JSON, ESLint
      vscode-langservers-extracted
    ];
  };

  home.shellAliases = {
    hxc = "hx $HOME/.config";
  };

  xdg.configFile.helix.source = ./helix;
}
