{
  flake.nixosModules.gtk = {
    pkgs,
    lib,
    ...
  }: 
  {
    programs = {
      dconf = {
        enable = lib.mkDefault true;
        profiles = {
          user = {
            databases = [
              {
                lockAll = false;
                settings = {
                  "org/gnome/desktop/interface" = {
                    color-scheme = "prefer-dark";
                  };
                };
              }
            ];
          };
        };
      };
    };

    environment.systemPackages = [
      pkgs.gtk3
      pkgs.gtk4
    ];
  };
}

