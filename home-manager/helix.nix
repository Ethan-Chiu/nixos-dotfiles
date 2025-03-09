{ inputs, pkgs, ... }:
let
  # Skips the input but impurifies the build (use --impure to rebuild)
  # helix = (builtins.getFlake "github:helix-editor/helix/master").packages.${pkgs.system}.default;

  # helix = inputs.helix.packages.${pkgs.system}.default;
in
{
  programs.helix = {
    enable = true;
    # package = helix;
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

  # xdg.configFile.helix.source = ./helix;
}
