{
  flake.nixosModules.assets =
    { config, ... }:
    let
      inherit (config.preferences) username;
    in
    {
      hjem.users.${username}.files = {
        ".config/backgrounds".source = ./wallpapers;
      };
    };
}
