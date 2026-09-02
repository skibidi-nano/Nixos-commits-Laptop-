{ config, pkgs, ... }:

{ 
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader & Kernels
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "cocktop";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Sound & Realtime
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Localization & Keymap
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };
  services.xserver.xkb = { layout = "de"; variant = ""; };
  console.keyMap = "de";

  # Desktop Environments: KDE Plasma 6 + Hyprland Session Provider
  services.desktopManager.plasma6.enable = true;
  programs.hyprland.enable = true; # Enables required system modules, polkit, and greeter hooks

  # XDG Portals for Hyprland/Noctalia communications
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Users
  users.users."j" = {
    isNormalUser = true;
    description = "j";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  # System-wide utilities only
  environment.systemPackages = with pkgs; [
    vim-full
    gparted
    doas
    qemu
  ];

  services.openssh.enable = true;
  programs.steam.enable = true;

  system.stateVersion = "26.05";
}
