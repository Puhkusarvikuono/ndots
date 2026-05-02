{ self, inputs, ... }: {

    flake.nixosModules.myMachineConfiguration = { pkgs, lib, ... }: {
        # Copy original configuration from /etc/nixos/configuration.nix
        # import any other modules from here
        imports = [
            self.nixosModules.myMachineHardware
            self.nixosModules.niri
        ];

        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # ...
    };

}
