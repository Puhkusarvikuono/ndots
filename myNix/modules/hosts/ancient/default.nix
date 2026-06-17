{ self, inputs, ... }:
{
  flake.nixosConfigurations.ancient = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.ancientConfiguration
    ];
  };
}
