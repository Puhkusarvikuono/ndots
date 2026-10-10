{
  flake.nixosModules.qt = {
    pkgs,
    lib,
    ...
  }: 
  {
    qt = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      kdePackages.qt6ct
    ];

    environment.sessionVariables.QT_QPA_PLATFORMTHEME = "qt6ct";
  };
}

