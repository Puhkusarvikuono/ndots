{

  flake.nixosModules.study =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.libreoffice-qt
        pkgs.zoom-us
      ];

    };
}
