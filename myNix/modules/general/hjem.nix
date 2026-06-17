{ inputs, ... }: {
  flake.nixosModules.koti = {
    config, 
    ...
  }: {
    imports = [
      inputs.hjem.nixosModules.default
    ];
    config = {
      hjem = {
        users.nixis = {
          enable = true;
          directory = "/home/nixis";
          user = "nixis";
        };
        clobberByDefault = true;
        };
    };
  };
}
  
