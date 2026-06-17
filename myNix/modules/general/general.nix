{ self, inputs, ... }:
{
  flake.nixosModules.general =
    { pkgs, config, lib, ... }:
    {
      imports = [
        self.nixosModules.gtk
        self.nixosModules.nix
      ];

    users.users.nixis = {
      isNormalUser = true;
      description = "nixis";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = self.packages.${pkgs.stdenv.hostPlatform.system}.environment;
    };
};
}
