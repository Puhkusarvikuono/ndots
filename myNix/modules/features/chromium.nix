{ self, inputs, ...}: {
  flake.nixosModules.chromium = {pkgs, lib, ...}: {
    programs.chromium.enable = true;

    environment.systemPackages = [
      pkgs.ungoogled-chromium
    ];

  };
}
