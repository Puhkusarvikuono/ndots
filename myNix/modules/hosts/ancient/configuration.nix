{ self, inputs, ... }:
{

  flake.nixosModules.ancientConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.ancientHardware
        self.nixosModules.niri
        self.nixosModules.gaming
        self.nixosModules.discord
        self.nixosModules.desktop
        self.nixosModules.private
        self.nixosModules.general
      ];

      # Display manager

      services.displayManager.ly.enable = true;

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "nixos"; # Define your hostname.
      networking.networkmanager.enable = true;

      system.stateVersion = "25.11";

    };
}
