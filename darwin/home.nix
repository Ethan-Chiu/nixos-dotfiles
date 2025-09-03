
{ inputs, config, pkgs, ... }:

let
  alias = {
    ll = "ls -l";
    ".." = "cd ..";
    "gl" = "lazygit";
  };
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ethan";
  home.homeDirectory = "/Users/ethan";

  imports = [
    ../home-manager/font.nix
    ../home-manager/helix.nix
    ../home-manager/yazi.nix
  ];

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    lazygit
    pass
  ];

  home.file = {};

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      # "github.com" = {
      #   identityFile = "~/.ssh/github_ed25519";
      #   # addKeysToAgent = "yes";
      # };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = alias;
  };

  programs.zsh = {
    enable = true;
    shellAliases = alias;
    initExtra = ''
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ethan/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ethan/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ethan/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ethan/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
    '';
  };

  programs.fzf.enable = true;
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.eza = {
    enable = true;
    icons = "auto";
    enableBashIntegration = true;
    enableZshIntegration = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  # programs.gpg.enable = true;
  # services.gpg-agent =  {
  #   enable = true;
  #   enableZshIntegration = true;
  #   pinentry.package = pkgs.pinentry-curses;
  # };
  

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

