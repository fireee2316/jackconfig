# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ 
	./hardware-configuration.nix
	];

  # EFI
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # hostname
  networking.hostName = "BBL";

  # WiFi + Bluetooth
  networking.wireless.enable = true;
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;


  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  # TZ
  time.timeZone = "Europe/London";

  # Internal language
  i18n.defaultLocale = "en_GB.UTF-8";

  # User account
  users.users.fireee = {
	isNormalUser = true;
 	extraGroups = [ "wheel" "networkmanager" ];

	# USER PACKAGES

	packages = with pkgs;
		[
		nemo-with-extensions
		unzip
		foot
 		obsidian
		flameshot
		heroic
		spotify
		freetube
		xrootd
		gfortran
		floorp-bin
		vscodium
		vesktop
		obs-studio
		audacity
		navidrome
		htop
		btop
		element-desktop
		prismlauncher
		karere
		];
	};
  environment.systemPackages = with pkgs;
	[
	# GLOBAL PACKAGES
	wget
	curl
	gh
	git
	librewolf
	blueman
	brightnessctl
	julia
	opensnitch-ui
	thunar-archive-plugin
	jq
	sutils
	# For HyprLand
	waybar
	mako
	awww
	rofi
	kdePackages.polkit-kde-agent-1
	wev
	
	];
  # Programs and services

  services.opensnitch = {
	enable = true;
	settings.DefaultAction = "deny";
	};

  programs.steam = {
	enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
	};

  services.gvfs.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  	stdenv.cc.cc.lib
  	gfortran.cc.lib
  	zlib
  	glibc
  	
  	# Graphics & Windowing Libraries for Makie/GLFW
  	libGL
  	libx11
  	libxcursor
  	libxrandr
  	libxinerama
  	libxi
        ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Flakes

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # HyprLand
  programs.hyprland = {
	enable = true;
	xwayland.enable = true;
	};

  environment.sessionVariables = {
	NIXOS_OZONE_WL = "1";
	};

  services.displayManager.sddm = 
	{ enable = true; 
	wayland.enable = true;};

  # GPU Stuff
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

  # System health

  boot.tmp.cleanOnBoot = true;
  services.fstrim.enable = true;

  # SYSTEM STATE VERSION
  ## DO NOT TOUCH (unless you wanna)

  system.stateVersion = "23.11";
}
