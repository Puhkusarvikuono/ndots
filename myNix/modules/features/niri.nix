{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, lib, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      config,
      ...
    }: 
    {
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {
          spawn-at-startup = [
            (lib.getExe self'.packages.myNoctalia)
          ];
          spawn-sh-at-startup = [
            "protonvpn-app"
          ];

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          input = {
            focus-follows-mouse = { };
            workspace-auto-back-and-forth = { };
            keyboard = {
              xkb.layout = "fi";

              repeat-rate = 25;
              repeat-delay = 250;
            };

            touchpad = {
              dwt = { };
              scroll-factor = 0.5;
              accel-speed = 0.1;
              tap = { };
              disabled-on-external-mouse = { };
            };

            mouse = {
              accel-profile = "flat";
            };
          };

          prefer-no-csd = { };

          gestures = {
            hot-corners = {
              off = { };
            };
          };

          layout = {
            center-focused-column = "never";
            gaps = 5;

            focus-ring = {
              width = 2;
            };
          };

          binds = {
            # toggle overview 
            "Mod+Return".toggle-overview = { };
            
            # terminal
            "Mod+X".spawn-sh = "${lib.getExe self'.packages.kitty}";
            "Mod+Shift+X".spawn-sh = "${lib.getExe self'.packages.alacritty}";

            # window control
            "Mod+W".close-window = { };
            "Mod+F".maximize-column = { };
            "Mod+G".fullscreen-window = { };
            "Mod+Shift+F".toggle-window-floating = { };
            "Mod+C".center-column = { };
            "Mod+Shift+K".show-hotkey-overlay = { };

            # app launcher
            "Mod+Space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
            
            "Mod+O".spawn-sh = "obsidian";
            "Mod+B".spawn-sh = "${lib.getExe pkgs.brave}";
            "Mod+E".spawn-sh = "${lib.getExe pkgs.nautilus}";
            "Mod+Shift+B".spawn-sh = "${lib.getExe pkgs.librewolf}";
            
            # quit niri
            "Mod+Shift+E".quit = {};
            
            # workspace window
            "Mod+H".move-column-left = { };
            "Mod+L".move-column-right = { };
            "Mod+K".move-workspace-up = { };
            "Mod+J".move-workspace-down = { };

            "Mod+Left".focus-column-left = { };
            "Mod+Right".focus-column-right = { };
            "Mod+Up".focus-workspace-up = { };
            "Mod+Down".focus-workspace-down = { };

            "Mod+1".focus-workspace = "w0";
            "Mod+2".focus-workspace = "w1";
            "Mod+3".focus-workspace = "w2";
            "Mod+4".focus-workspace = "w3";
            "Mod+5".focus-workspace = "w4";

            "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
            "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";
            "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

            "Mod+Shift+1".move-column-to-workspace = "w0";
            "Mod+Shift+2".move-column-to-workspace = "w1";
            "Mod+Shift+3".move-column-to-workspace = "w2";
            "Mod+Shift+4".move-column-to-workspace = "w3";
            "Mod+Shift+5".move-column-to-workspace = "w4";
          };

          workspaces =
            let
              settings = {
                layout.gaps = 5;
              };
            in
            {
              "w0" = settings;
              "w1" = settings;
              "w2" = settings;
              "w3" = settings;
              "w4" = settings;
            };
        };
      };
    };
}
