{ self, inputs, ...}: {
  flake.nixosModules.desktop = {pkgs, lib, ...}: {

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
        python3
        go
        unzip
        gh
        nh
        bat
        man
        eza
        self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovim
        self.packages.${pkgs.stdenv.hostPlatform.system}.kitty
   ];
    programs.neovim = {
           enable = true;
           defaultEditor = true;
           package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovim;
    };

    programs.fish = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.fish;
    };
  };
}
