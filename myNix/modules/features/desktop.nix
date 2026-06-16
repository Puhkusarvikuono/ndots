{ self, inputs, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, lib, ... }:
    {

      environment.systemPackages = with pkgs; [
        cliphist
        zip
        killall
        fzf
        htop
        btop
        fd
        ripgrep
        fastfetch
        tree-sitter
        yt-dlp
        imagemagick
        nil
        statix
        manix
        nix-inspect
        direnv
        unzip
        gh
        nh
        bat
        man
        pcmanfm
        bibata-cursors
        eza
        self.packages.${pkgs.stdenv.hostPlatform.system}.kitty
      ];

      security.polkit.enable = true;

      programs.fish = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.fish;
      };

      programs.yazi = {
        enable = true;
      };
    };
}
