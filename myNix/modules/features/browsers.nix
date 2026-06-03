{ self, inputs, ...}: {
  flake.nixosModules.browsers = {pkgs, lib, ...}: {

    imports = [
        self.nixosModules.chromium
	self.nixosModules.firefox
    ];
};
}
