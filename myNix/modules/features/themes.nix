{ self, inputs, ...}: {
  flake.nixosModules.themes = {pkgs, lib, ...}: {
      imports = [
        self.nixosModules.gtk
      ];
};
}

