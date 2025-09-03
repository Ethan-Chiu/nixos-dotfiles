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
  home.homeDirectory = "/home/ethan";

  imports = [
    ./font.nix
    ./helix.nix
    ./zen.nix
    ./niri.nix
    ./swww.nix
    ./wezterm.nix
    ./yazi.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    hello

    waybar
    fuzzel

    impala
    bluetui

    lazygit

    openconnect
    networkmanager-openconnect
    networkmanagerapplet

    wl-color-picker

    pass

    unzip
    zip
  
    slack
    # discord # This is broken
    vesktop
    # # Maybe you want to install Nerd Fonts with a limited number of fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration.
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # Activating the configuration will then make '~/.screenrc' a symlink to 
    # the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/github_ed25519";
        # addKeysToAgent = "yes";
      };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = alias;
  };

  programs.zsh = {
    enable = true;
    shellAliases = alias;
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

  programs.gpg.enable = true;
  services.gpg-agent =  {
    enable = true;
    enableZshIntegration = true;
    pinentry.package = pkgs.pinentry-curses;
  };
  

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

