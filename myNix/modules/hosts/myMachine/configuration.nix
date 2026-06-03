{ self, inputs, ... }: {

	flake.nixosModules.myMachineConfiguration = { pkgs, lib, ... }: {
		imports = [
			self.nixosModules.myMachineHardware
			self.nixosModules.niri
			self.nixosModules.browsers
			self.nixosModules.discord
            self.nixosModules.desktop
            self.nixosModules.themes
		];

		nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # Display manager

        services.displayManager.ly.enable = true;

		  # Battery

  		  services.upower.enable = true;

		  # Bluetooth

		  hardware.bluetooth.enable = true;

		  # Bootloader.
		  boot.loader.systemd-boot.enable = true;
		  boot.loader.efi.canTouchEfiVariables = true;

		  networking.hostName = "nixos"; # Define your hostname.
		  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

		  # Configure network proxy if necessary
		  # networking.proxy.default = "http://user:password@proxy:port/";
		  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

		  # Enable networking
		  networking.networkmanager.enable = true;

		  # Set your time zone.
		  time.timeZone = "Europe/Helsinki";

		  # Select internationalisation properties.
		  i18n.defaultLocale = "en_US.UTF-8";

		  i18n.extraLocaleSettings = {
		    LC_ADDRESS = "fi_FI.UTF-8";
		    LC_IDENTIFICATION = "fi_FI.UTF-8";
		    LC_MEASUREMENT = "fi_FI.UTF-8";
		    LC_MONETARY = "fi_FI.UTF-8";
		    LC_NAME = "fi_FI.UTF-8";
		    LC_NUMERIC = "fi_FI.UTF-8";
		    LC_PAPER = "fi_FI.UTF-8";
		    LC_TELEPHONE = "fi_FI.UTF-8";
		    LC_TIME = "fi_FI.UTF-8";
		  };

		  # Configure keymap in X11
		  services.xserver.xkb = {
		    layout = "fi";
		    variant = "nodeadkeys";
		  };

		  # Configure console keymap
		  console.keyMap = "fi";

		  # Define a user account. Don't forget to set a password with ‘passwd’.
		  users.users.nixis = {
		    isNormalUser = true;
		    description = "nixis";
		    extraGroups = [ "networkmanager" "wheel" ];
		    packages = with pkgs; [];
            	    shell = pkgs.fish;
		  };

		  # Allow unfree packages
		  nixpkgs.config.allowUnfree = true;

		  fonts.packages = with pkgs; [
		  	nerd-fonts.jetbrains-mono
		  ];




		  # List packages installed in system profile. To search, run:
		  # $ nix search wget
		  environment.systemPackages = with pkgs; [
		    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
		    wget
		    git
		  ];



		# Some programs need SUID wrappers, can be configured further or are
		  # started in user sessions.
		  # programs.mtr.enable = true;
		  # programs.gnupg.agent = {
		  #   enable = true;
		  #   enableSSHSupport = true;
		  # };

		  # List services that you want to enable:

		  # Enable the OpenSSH daemon.
		  # services.openssh.enable = true;

		  # Open ports in the firewall.
		  # networking.firewall.allowedTCPPorts = [ ... ];
		  # networking.firewall.allowedUDPPorts = [ ... ];
		  # Or disable the firewall altogether.
		  # networking.firewall.enable = false;

		  # This value determines the NixOS release from which the default
		  # settings for stateful data, like file locations and database versions
		  # on your system were taken. It‘s perfectly fine and recommended to leave
		  # this value at the release version of the first install of this system.
		  # Before changing this value read the documentation for this option
		  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
		  system.stateVersion = "25.11"; # Did you read the comment?

	};
}
