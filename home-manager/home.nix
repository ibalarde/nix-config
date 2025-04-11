{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "isaac";
  home.homeDirectory = "/home/isaac";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
  
  nixpkgs.config.allowUnfree = true;
  
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    signal-desktop
    obsidian
    onlyoffice-bin
    python3Full
    nmap
    tor-browser-bundle-bin
    btop
    ncspot
    pyright
    prismlauncher
    ranger
  ];

  # Waybar
  programs.waybar = {
    enable = true;
  };

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
        gruvbox-material
        auto-pairs
        nerdtree
        coc-nvim
        coc-clangd
        coc-pyright
        coc-html
        barbar-nvim
        nvim-web-devicons
    ];
    extraConfig = ''
        color gruvbox-material
        set number
        syntax on
        set tabstop=4
        set softtabstop=4
        set shiftwidth=4
        set expandtab
        filetype plugin indent on
        filetype plugin on
        
        map <F1> :NERDTree<CR> 
    '';
  };
  
  # java env
  programs.java.enable = true;

  programs.foot = {
    enable = true;
    settings = {
        main = {
          font = "size=11";
        };
    };
  };

  # zathura document reader
  programs.zathura = {
    enable = true;
  };

  # swaylock
  programs.swaylock = {
    enable = true;
  };

  # git + gh
  programs.git = {
    enable = true;
    userEmail = "isaac.balardelle@gmail.com";
    userName = "ibalarde";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  # i3blocks
  programs.i3blocks = {
    enable = true;
    bars = {
      config = {
        time = {
          command = ''
              date +" %a, %d %b - %H:%M:%S"
          '';
          interval = 1;
        };
        battery = {
          command = ''
            echo "Batt: $(cat /sys/class/power_supply/BAT0/capacity)%"
          '';
          interval = 30;
          background = "#f0a224";
        };
      };
    };
  };

  # Shell stuff
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };

  programs.starship = {
    enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/isaac/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
