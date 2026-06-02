{ self, inputs, ...}: {
  flake.nixosModules.chromium = {pkgs, lib, ...}: {
    programs.chromium = {
        enable = true;
        extensions = [
            "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
            "eimadpbcbfnmbkopoojfekhnkhdbieeh;https://clients2.google.com/service/update2/crx" # dark reader
          ];
    };

    environment.systemPackages = [
        inputs.helium.defaultPackage.${pkgs.stdenv.hostPlatform.system}
    ];
  };
}
