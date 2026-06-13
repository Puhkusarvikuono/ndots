{ self, inputs, ... }:
{

  flake.nixosModules.discord =
    { pkgs, libs, ... }:
    {
      environment.systemPackages = [
        pkgs.vesktop
        pkgs.discord
      ];

    };
}
