# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
      ./services
      ./desktop
    ];

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };
  
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixlaptop"; # Define your hostname.

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };
  
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable passwordless sudo
  security.sudo.wheelNeedsPassword = false;
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.isaac = {
    isNormalUser = true;
    description = "isaac";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" "adbusers" "dialout" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-7.0.20"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    mako
    wl-clipboard
    grim
    slurp
    alacritty
    wmenu
    firefox
    fuzzel
    brightnessctl
    vesktop
    gcc
    cmake
    gnumake
    networkmanagerapplet
    networkmanager-openconnect
    fastfetch
    gpclient
    ouch
    nodejs_23
    clang-tools
    vintagestory
    remmina
    rustup
    libbsd
    ntfs3g
    man-pages
    man-pages-posix
  ];

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
  };

  services.printing.enable = true;

  hardware.enableAllFirmware = true;

  # Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # ADB
  programs.adb.enable = true;
  
  # VirtualBox
  virtualisation.virtualbox.host.enable = true;

  # mullvad
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  # Font stuff
  fonts.packages = with pkgs; [
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
    font-awesome
    liberation_ttf
    fira-code
  ];

  # Desktop environment stuff
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
  };

  # Audio stuff
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Lock screen (greetd + tuigreet)
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --time --cmd sway";
        user = "greeter";
      };
    };
  };

  system.stateVersion = "24.05"; # Did you read the comment?

}
