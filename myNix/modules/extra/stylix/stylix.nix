{ self, inputs, ... }:
{
  flake.nixosModules.stylix =
    {
      config,
      pkgs,
      ...
    }:
    let
      inherit (config.preferences) colorScheme;
    in
    {
      imports = [
        inputs.stylix.nixosModules.stylix
        self.nixosModules.stylixHjem
        self.nixosModules.assets
        self.nixosModules.xdg
        self.nixosModules.gtk
      ];

      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/${colorScheme}.yaml";

        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 25;
        };

        fonts = {
          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };
          monospace = {
            package = pkgs.nerd-fonts.geist-mono;
            name = "Geist Mono";
          };
          sansSerif = {
            package = pkgs.geist-font;
            name = "Geist";
          };
          serif = config.stylix.fonts.sansSerif;
          sizes = {
            applications = 12;
            desktop = 10;
            popups = 10;
            terminal = 10;
          };
        };

        polarity = "dark";

        icons = {
          enable = true;
          package = pkgs.gruvbox-plus-icons;
          dark = "Gruvbox-Plus-Dark";
          light = "Gruvbox-Plus-Light";
        };

        opacity.applications = 0.8;

      };
    };
}
