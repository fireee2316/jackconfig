# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix  ];

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
		foot
		discord
		heroic
		spotify
		xrootd
		gfortran
		librewolf
		vscodium
		vesktop
		obs-studio
		audacity
		navidrome
		];
	};
  environment.systemPackages = with pkgs;
	[
	# GLOBAL PACKAGES
	wget
	curl
	git
	librewolf
	blueman
	brightnessctl
	julia
	opensnitch-ui

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

  # Firewall

  services.opensnitch.rules = {
  rule-000-librewolf = {
	name = "Allow LibreWolf";
	enabled = true;
	action = "allow";
	duration = "always";
	operator = {
		type = "simple";
		sensitive = false;
		operand = "process.path";
		data = "${lib.getBin pkgs.librewolf}/lib/librewolf/librewolf";
		};
	};
  rule-100-xrootd = {
    name = "Allow xrootd";
    enabled = true;
    action = "allow";
    duration = "always";
    operator = {
      type = "simple";
      sensitive = false;
      operand = "process.path";
      data = "${lib.getBin pkgs.xrootd}/bin/xrootd";
    };
  };

  rule-100-heroic = {
    name = "Allow Heroic";
    enabled = true;
    action = "allow";
    duration = "always";
    operator = {
      type = "simple";
      sensitive = false;
      operand = "process.path";
      data = "${lib.getBin pkgs.heroic}/bin/heroic";
    };
  };

  rule-500-steam = {
    name = "Allow Steam";
    enabled = true;
    action = "allow";
    duration = "always";
    operator = {
      type = "simple";
      sensitive = false;
      operand = "process.path";
      data = "${lib.getBin pkgs.steam}/bin/steam";
    };
  };
  
  
  rule-100-vesktop = {
    name = "Allow Vesktop";
    enabled = true;
    action = "allow";
    duration = "always";
    operator = {
      type = "simple";
      sensitive = false;
      operand = "process.path";
      data = "${lib.getBin pkgs.vesktop}/bin/vesktop";
    };
  };

  rule-100-spotify = {
    name = "Allow Spotify";
    enabled = true;
    action = "allow";
    duration = "always";
    operator = {
      type = "simple";
      sensitive = false;
      operand = "process.path";
      data = "${lib.getBin pkgs.spotify}/bin/spotify";
    };
  };

  rule-100-freetube = {
    name = "Allow FreeTube";
    enabled = true;
    action = "allow";
    duration = "always";
    operator = {
      type = "simple";
      sensitive = false;
      operand = "process.path";
      data = "${lib.getBin pkgs.freetube}/bin/freetube";
    };
  };

  rule-100-nix = {
    name = "Allow Nix";
    enabled = true;
    action = "allow";
    duration = "always";
    operator = {
      type = "simple";
      sensitive = false;
      operand = "process.path";
      data = "${lib.getBin pkgs.nix}/bin/nix";
    };
  };

  rule-100-nix-daemon = {
    name = "Allow Nix Daemon";
    enabled = true;
    action = "allow";
    duration = "always";
    operator = {
      type = "simple";
      sensitive = false;
      operand = "process.path";
      data = "${lib.getBin pkgs.nix}/bin/nix-daemon";
    };
  };

  rule-100-NetworkManager = {
    name = "Allow NetworkManager";
    enabled = true;
    action = "allow";
    duration = "always";
    operator = {
      type = "simple";
      sensitive = false;
      operand = "process.path";
      data = "${lib.getBin pkgs.networkmanager}/bin/NetworkManager";
    };
  };

  rule-000-localhost = {
  name = "Allow localhost";
  enabled = true;
  action = "allow";
  duration = "always";
  operator = {
    type = "regexp";
    operand = "dest.ip";
    sensitive = false;
    data = "^(127\\.0\\.0\\.1|::1)$";
    list = [ ];
  };
};

  };
  # SYSTEM STATE VERSION
  ## DO NOT TOUCH (unless you wanna)

  system.stateVersion = "23.11";
}
