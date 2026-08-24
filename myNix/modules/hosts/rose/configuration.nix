{ self, inputs, ... }:
{

  flake.nixosModules.roseConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.roseHardware
        self.nixosModules.base
        self.nixosModules.general
        self.nixosModules.desktop
        self.nixosModules.gaming
        self.nixosModules.discord
        self.nixosModules.private
        self.nixosModules.niri
      ];

      # Display manager

      services.displayManager.ly.enable = true;

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "nixos"; # Define your hostname.
      networking.networkmanager.enable = true;

      system.stateVersion = "26.05";

    };
}
