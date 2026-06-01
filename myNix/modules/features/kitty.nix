{
  self,
  inputs,
  ...
}: {
  flake.wrappersModules.kitty = {
    config,
    lib,
    ...
  }: {
    options.shell = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
    config = {
      args = lib.mkAfter (lib.optionals (config.shell != "") [config.shell]);
      settings = {
        enable_audio_bell = "no";

        font_size = 10;
        font_family = "JetBrainsMono Nerd Font";

        cursor_text_color = "background";

        allow_remote_control = "yes";
        shell_integration = "enabled";

        cursor_trail = 3;

        map = [
          "alt+1 goto_tab 1"
          "alt+2 goto_tab 2"
          "alt+3 goto_tab 3"
          "alt+4 goto_tab 4"
          "alt+5 goto_tab 5"
          "alt+6 goto_tab 6"
          "alt+7 goto_tab 7"
          "alt+8 goto_tab 8"
          "alt+9 goto_tab 9"
          "ctrl+shift+w close_tab"
          "ctrl+t new_tab_with_cwd"
          "ctrl+shift+t new_tab"
        ];

        background = "#1d2021";
        foreground = "#d4be98";

        cursor = "#a89984";

        selection_foreground = "#d4be98";
        selection_background = "#1d2021";

        active_tab_foreground = "#444444";
        active_tab_background = "#d4be98";
        inactive_tab_background = "#d4be98";

        color0 = "#665c54";
        color8 = "#928374";
        color1 = "#ea6962";
        color9 = "#ea6962";
        color2 = "#a9b665";
        color10 = "#a9b665";
        color3 = "#e78a4e";
        color11 = "#d8a657";
        color4 = "#7daea3";
        color12 = "#7daea3";
        color5 = "#d3869b";
        color13 = "#d3869b";
        color6 = "#89b482";
        color14 = "#89b482";
        color7 = "#d4be98";
        color15 = "#d4be98";
      };
    };
  };

  perSystem = {pkgs, ...}: {
    packages.kitty =
      (inputs.wrappers.wrapperModules.kitty.apply {
        inherit pkgs;
        imports = [self.wrappersModules.kitty];
      }).wrapper;
  };
}
