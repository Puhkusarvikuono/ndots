{
  flake.nixosModules.gaming = 
    { pkgs, ... }:
    {
    programs.steam.enable = true;

    environment.systemPackages = [
      pkgs.retroarch-free
    ];
  };
}
