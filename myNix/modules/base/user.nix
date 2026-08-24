{
  flake.nixosModules.base =
    { lib, ... }:
    {
      options.preferences = {
        username = lib.mkOption {
          type = lib.types.str;
          default = "mixis";
        };
        colorScheme = lib.mkOption {
          type = lib.types.str;
          default = "rose-pine-moon";
        }; 
      };
    };
}

