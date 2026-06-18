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
            (lib.getExe (
              pkgs.writeShellScriptBin "wallpaper" "${lib.getExe pkgs.swaybg} -i ${self.wallpaper} -m fill"
            ))
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
              scroll-factor = 0.7;
              accel-speed = 0.1;
              tap = { };
            };

            mouse = {
              accel-profile = "flat";
            };
          };

          prefer-no-csd = { };

          layout = {
            center-focused-column = "never";
            gaps = 5;

            focus-ring = {
              width = 2;
            };
          };

          binds = {
            # Overview

            "Mod+Return".toggle-overview = { };
            
            "Mod+X".spawn-sh = "${lib.getExe self'.packages.kitty}";
            "Mod+Shift+X".spawn-sh = "${lib.getExe self'.packages.alacritty}";
            "Mod+W".close-window = { };
            "Mod+F".maximize-column = { };
            "Mod+G".fullscreen-window = { };
            "Mod+Shift+F".toggle-window-floating = { };
            "Mod+C".center-column = { };
            "Mod+Space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
            "Mod+O".spawn-sh = "obsidian";
            "Mod+B".spawn-sh = "helium";
            "Mod+E".spawn-sh = "nautilus";
            "Mod+Shift+B".spawn-sh = "librewolf";
            "Mod+Shift+E".quit = {};
            "Mod+H".focus-column-left = { };
            "Mod+L".focus-column-right = { };
            "Mod+K".focus-window-up = { };
            "Mod+J".focus-window-down = { };

            "Mod+Left".move-column-left = { };
            "Mod+Right".move-column-right = { };
            "Mod+Up".move-window-up = { };
            "Mod+Down".move-window-down = { };

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
