# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).


 
# nigger

 
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.flatpak.enable = true;

  networking.hostName = "JL"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Enable GNOME.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;


  

  # Configure keymap in X11
  services.xserver.xkb.layout = "gb";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jack= {
    isNormalUser = true;
    initialPassword = "123";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
	foot
	librewolf
	nemo
	task-keeper
	vesktop
	flameshot
	spotify
	prismlauncher
	heroic
	gh
	git
    ];
  };

  environment.systemPackages = with pkgs; [
	wget
	curl
	git
	blueman
	];

  nixpkgs.config.allowUnfree = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
	modesetting.enable = true;
	powerManagement.enable = false;
	powerManagement.finegrained = false;
	open = true;
	nvidiaSettings = true;
	package = config.boot.kernelPackages.nvidiaPackages.stable;
	};
  programs.steam = {
	enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
	};

  system.stateVersion = "26.05";
}

