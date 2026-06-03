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
      pkgs.ungoogled-chromium
    ];
  };
}
