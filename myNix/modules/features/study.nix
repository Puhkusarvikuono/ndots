{

  flake.nixosModules.study =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.libreoffice-qt
      ];

    };
}
