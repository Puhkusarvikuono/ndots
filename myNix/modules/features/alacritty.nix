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
      packages.alacritty = inputs.wrapper-modules.wrappers.alacritty.wrap {
        inherit pkgs;
        settings = {
          general = {
            import = [ "~/.config/alacritty/theme.toml" ];
          }; 
          window = {
            opacity = 0.95;
          };
        };
      };
    };
}
