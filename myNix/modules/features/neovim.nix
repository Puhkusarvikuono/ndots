{ self, inputs, ... }: {
	  flake.nixosModules.neovim = {
    config,
    wlib,
    lib,
    pkgs,
    ...
  }: {

	environment.systemPackages = with pkgs; [
		self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovim
	];
};
	perSystem = { pkgs, self', ... }: {
		packages.myNeovim = inputs.wrapper-modules.wrappers.neovim.wrap {
			inherit pkgs;
			settings.config_directory = "/home/nixis/myNix/modules/features/nvim";
		};

};
}
