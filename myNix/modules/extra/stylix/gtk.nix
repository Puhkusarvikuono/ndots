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
                    icon-theme = "Gruvbox-Plus-Dark";
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
      pkgs.gruvbox-plus-icons
      pkgs.gtk3
      pkgs.gtk4
    ];
  };
}

