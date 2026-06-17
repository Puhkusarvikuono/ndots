{ self, inputs, ... }:
{
  flake.nixosModules.general =
    { pkgs, lib, ... }:
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
      shell = pkgs.fish;
    };
};
}
