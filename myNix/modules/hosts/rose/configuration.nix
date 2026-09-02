{ self, inputs, ... }:
{

  flake.nixosModules.roseConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.roseHardware
        self.nixosModules.base
        self.nixosModules.roseOptions
        self.nixosModules.general
        self.nixosModules.desktop
        self.nixosModules.gaming
        self.nixosModules.discord
        self.nixosModules.private
        self.nixosModules.study
        self.nixosModules.niri
      ];

      # Display manager

      services.displayManager.ly.enable = true;
      services.thermald.enable = true;
      services.auto-cpufreq.enable = true;

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          intel-media-driver
          vpl-gpu-rt
        ];
      };


      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "nixos"; # Define your hostname.
      networking.networkmanager.enable = true;

      system.stateVersion = "26.05";

    };
}
