{ self, inputs, ...}: {
  flake.nixosModules.environment = {pkgs, lib, ...}: {
	environment.systemPackages = with pkgs; [
        cliphist
        zip
        killall
        fzf
        htop
        btop
        fd
        zoxide
        ripgrep
        fastfetch
        tree-sitter
        yt-dlp
        imagemagick
        nil
        python3
        go
        unzip
        gh
        nh
        self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovim
   ];

 };
}
