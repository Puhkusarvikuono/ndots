{ self, inputs, ... }: {
    # copy hardware inside
    flake.nixosModules.myMachineHardware = { config, lib, pkgs, modulesPath, ... }: {
        imports = [
            (modulesPath + "/installer/scan/not-detected.nix")
        ];

        # ...

        fileSystems."/" = {
            device = ...
            fsType = "..."
        };

        nixpkgs.hostPlatform...
    };

}
