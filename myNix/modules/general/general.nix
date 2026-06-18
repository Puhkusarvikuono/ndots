{ self, inputs, ... }:
{
  flake.nixosModules.general =
    { pkgs, config, lib, ... }:
    {
      imports = [
        self.nixosModules.nix
        self.nixosModules.hjem
        self.nixosModules.stylix
      ];

    users.users.${config.preferences.username} = {
      isNormalUser = true;
      description = "${config.preferences.username}'s account";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = self.packages.${pkgs.stdenv.hostPlatform.system}.environment;
    };

};
}
