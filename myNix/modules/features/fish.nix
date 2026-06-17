{ inputs, lib, ... }:
{
  perSystem =
    {
      pkgs,
      self',
      ...
    }:
    let
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

            function y
              set tmp (mktemp -t "yazi-cwd.XXXXXX")
              command yazi $argv --cwd-file="$tmp"
              if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
                builtin cd -- "$cwd"
              end
              command rm -f -- "$tmp"
            end
            
            if type -q direnv
              direnv hook fish | source
            end

            ${lib.getExe pkgs.any-nix-shell} fish --info-right | source
            ${lib.getExe self'.packages.myStarship} init fish | source
            ${lib.getExe pkgs.zoxide} init fish | source
          '';
    in
    {
      packages.fish = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.fish;
        runtimeInputs = [
          pkgs.zoxide
        ];
        flags = {
          "-C" = "source ${fishConf}";
        };
      };
    };
}
