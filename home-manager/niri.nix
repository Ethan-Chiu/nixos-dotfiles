{ inputs, pkgs, ... }:

{
  imports = [
    inputs.niri.homeModules.niri
  ];

  home.file.".config/niri/light-down.sh" = {
    executable = true;
    text = builtins.readFile ./niri/light-down.sh;
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
}
