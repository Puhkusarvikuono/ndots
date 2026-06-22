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
                    icon-theme = "rose-pine-moon";
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
      pkgs.rose-pine-icon-theme
      pkgs.gtk3
      pkgs.gtk4
    ];
  };
}

