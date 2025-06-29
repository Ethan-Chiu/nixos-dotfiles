{ inputs, pkgs, ... }:

{
  home.packages = [ inputs.swww.packages.${pkgs.system}.swww ];

  home.file.".config/niri/start-wallpaper.sh" = {
    executable = true;
    text = builtins.readFile ./niri/start-wallpaper.sh;
  };
}

