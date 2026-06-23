{ self, inputs, ... }:
{

  flake.nixosModules.ancientConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.ancientHardware
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
        extraPackages = with pkgs; [
          intel-media-driver
          intel-vaapi-driver
          vpl-gpu-rt
        ];
      };


      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "nixos"; # Define your hostname.
      networking.networkmanager.enable = true;

      system.stateVersion = "25.11";

    };
}
