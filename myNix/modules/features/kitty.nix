{
  inputs,
  self,
  ...
}:
{
  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.kitty = inputs.wrapper-modules.wrappers.kitty.wrap {
        inherit pkgs;
        settings = {
          enable_audio_bell = "no";
          background_opacity = 0.95;
          dynamic_background_opacity = "yes";
          font_size = 10;
          font_family = "JetBrainsMono Nerd Font";
          cursor_text_color = "background";

          allow_remote_control = "yes";
          shell_integration = "enabled";

          cursor_trail = 3;
        };
      };
    };
}
