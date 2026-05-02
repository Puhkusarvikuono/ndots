{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

    perSystem = { pkgs, lib, self' ... }: {
        packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
            inherit pkgs;
            settings = {
                spawn-at-startup = [
                    (lib.getExe self'.packages.myNoctalia)
                ];

                xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

                input = {
                    focus-follows-mouse = null;

                    keyboard = {
                        xkb.layout = "fi";

                        repeat-rate = 40;
                        repeat-delay = 250;
                    };

                    touchpad = {
                        natural-scroll = null;
                        tap = null;
                    };

                    mouse = {
                        accel-profile = "flat";
                    };
                };

                layout = {
                    gaps = 5;

                    focus-ring = {
                        width = 2;
                    };
                };

                binds = {
                    "Mod+X".spawn-sh = lib.getExe pkgs.kitty;
                    "Mod+W".close-window = null;
                    "Mod+F".maximise-column = null;
                    "Mod+G".fullscreen-window = null;
                    "Mod+Shift+F".toggle-window-floating = null;
                    "Mod+C".center-column = null;


                };
            };
        };
    };
}
