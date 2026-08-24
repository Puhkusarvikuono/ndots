{ self, inputs, ... }:
{
  flake.nixosConfigurations.rose = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.roseConfiguration
    ];
  };
}
