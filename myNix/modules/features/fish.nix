{ inputs, self, ... }:
{
  perSystem =
    {
      lib,
      pkgs,
      self',
      ...
    }: let
    fishConf =
      pkgs.writeText "fishy-fishy"
      # fish
      ''
        set fish_greeting
        alias ls="eza"
        alias la="eza -lah"
        alias cat="bat"
        alias ga="git add"
        alias gc="git commit -m"
        alias ff="fastfetch"
        ${lib.getExe self'.packages.myStarship} init fish | source
        ${lib.getExe pkgs.zoxide} init fish | source
      '';
  in {
    packages.fish = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.fish;
      runtimeInputs = [
        pkgs.zoxide
	self'.packages.neovimFull
      ];
      flags = {
        "-C" = "source ${fishConf}";
      };
      env = {
      	EDITOR = lib.getExe self'.packages.neovimFull;
      };
    };
  };
}


