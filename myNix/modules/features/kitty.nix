{ self, inputs, ... }: {
	flake.nixosModules.kitty = { config, lib, ... }: {
	};
		
	perSystem = { pkgs, self', lib, ... }: {
		packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
		inherit pkgs;
		settings = {
			enable_audio_bell = "no";
			shell_integration = "enabled";
			font_size = 10;
			font_family = "JetBrainsMono Nerd Fonts";
			
			cursor_trail = 2;
			confirm_os_window_close = -1;
			cursor = "#fe8019";
		};
	};
	};
}
