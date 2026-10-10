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
        extraSettings = [
          { include = [ { optional = true; } "~/.config/niri/noctalia.kdl" ]; }
        ];
        settings = {
          spawn-at-startup = [
            "noctalia"
          ];
          spawn-sh-at-startup = [
            "protonvpn-app"
          ];

          cursor = {
            xcursor-theme = "Bibata-Modern-Classic";
            xcursor-size = 25;
          };

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

            # Noctalia

            # Lock

            "Mod+Shift+Return".spawn-sh = "noctalia msg session lock";
            

            # app launcher
            "Mod+Space".spawn-sh = "noctalia msg panel-toggle launcher";
            "Mod+S".spawn-sh = "noctalia msg panel-toggle control-center";
            "Mod+Comma".spawn-sh = "noctalia msg settings-toggle";
            
            "Mod+O".spawn-sh = "obsidian";
            "Mod+B".spawn-sh = "${lib.getExe pkgs.brave}";
            "Mod+E".spawn-sh = "${lib.getExe pkgs.nautilus}";
            "Mod+Shift+B".spawn-sh = "${lib.getExe pkgs.librewolf}";
            
            # quit niri
            "Mod+Shift+E".quit = {};
            
            # workspace window
            "Mod+Left".move-column-left = { };
            "Mod+Right".move-column-right = { };
            "Mod+Up".move-workspace-up = { };
            "Mod+Down".move-workspace-down = { };

            "Mod+H".focus-column-left = { };
            "Mod+L".focus-column-right = { };
            "Mod+K".focus-workspace-up = { };
            "Mod+J".focus-workspace-down = { };

            "Mod+Shift+H".focus-monitor-left = { };
            "Mod+Shift+L".focus-monitor-right = { };

            # workspace monitor

            "Mod+Shift+Left".move-window-to-monitor-left = { };
            "Mod+Shift+Right".move-window-to-monitor-right = { };

            "Mod+Ctrl+Shift+Left".move-workspace-to-monitor-left = { };
            "Mod+Ctrl+Shift+Right".move-workspace-to-monitor-right = { };

            # workspace switching

            "Mod+1".focus-workspace = "w0";
            "Mod+2".focus-workspace = "w1";
            "Mod+3".focus-workspace = "w2";
            "Mod+4".focus-workspace = "w3";
            "Mod+5".focus-workspace = "w4";

            "XF86AudioRaiseVolume".spawn-sh = "noctalia msg volume-up"; 
            "XF86AudioLowerVolume".spawn-sh = "noctalia msg volume-down";
            "XF86AudioMute".spawn-sh = "noctalia msg volume-mute";
            "XF86MonBrightnessUp".spawn-sh = "noctalia msg brightness-up";
            "XF86MonBrightnessDown".spawn-sh = "noctalia msg brightness-down";

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
