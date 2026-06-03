{ self, inputs, ... }: {
	  flake.modules.neovim = {
    config,
    wlib,
    lib,
    pkgs,
    ...
  }: {
	options = {};
	config = {
		settings.config_directory = ./.;
		specs.plugins = {
			data = [];
		};
	};
	};
	perSystem = { pkgs, self', ... }: {
		packages.myNeovim = inputs.wrapper-modules.wrappers.neovim.wrap {
			inherit pkgs;
			imports = [
				self.modules.neovim
			];
		};

	};
}

