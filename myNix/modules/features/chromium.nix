{ self, inputs, ...}: {
  flake.nixosModules.chromium = {pkgs, lib, ...}: {
    programs.chromium = {
        enable = true;
        extensions = [
            "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
            "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
          ];
    };

    environment.systemPackages = [
        inputs.helium.defaultPackage.${pkgs.stdenv.hostPlatform.system}
    ];
  };
}
