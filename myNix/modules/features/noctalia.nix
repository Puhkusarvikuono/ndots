{ self, inputs, ... }:
{

  flake.nixosModules.noctalia =
    { pkgs, libs, ... }:
    {
      imports = [
        inputs.noctalia.nixosModules.default
      ];

      programs.noctalia = {
        enable = true;
        recommendedServices.enable = true;
      };
    };
}
