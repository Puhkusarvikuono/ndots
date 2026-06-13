{

  flake.nixosModules.private =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.proton-vpn-cli
        pkgs.proton-pass
        pkgs.obsidian
      ];

    };
}
