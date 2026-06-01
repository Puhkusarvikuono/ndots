{ self, inputs, ...}: {
  flake.nixosModules.chromium = {pkgs, lib, ...}: {
    programs.chromium = {
        enable = true;
    };

    environment.systemPackages = [
        inputs.helium.defaultPackage.${pkgs.stdenv.hostPlatform.system}
    ];
  };
}
