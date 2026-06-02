{ self, inputs, ...}: {
  flake.nixosModules.themes = {pkgs, lib, ...}: {
      imports = [
        flake.nixosModules.gtk
      ];
};
}

