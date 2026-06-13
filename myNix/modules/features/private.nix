{

  flake.nixosModules.private =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.proton-vpn
        pkgs.proton-pass
        pkgs.obsidian
      ];

    };
}
