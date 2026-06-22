{ self, inputs, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.firefox
        self.nixosModules.chromium
      ];

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        ubuntu-sans
        cm_unicode
        corefonts
        unifont
      ];
      
      fonts.fontconfig.defaultFonts = {
        serif = ["Ubuntu Sans"];
        sansSerif = ["Ubuntu Sans"];
        monospace = ["JetBrainsMono Nerd Font"];
      };

      services.upower.enable = true;
      security.polkit.enable = true;
      hardware = {
        enableAllFirmware = true;
        bluetooth.enable = true;
        bluetooth.powerOnBoot = true;

        opengl = {
          enable = true;
          driSupport32Bit = true;
        };
      };

      time.timeZone = "Europe/Helsinki";
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "fi_FI.UTF-8";
        LC_IDENTIFICATION = "fi_FI.UTF-8";
        LC_MEASUREMENT = "fi_FI.UTF-8";
        LC_MONETARY = "fi_FI.UTF-8";
        LC_NAME = "fi_FI.UTF-8";
        LC_NUMERIC = "fi_FI.UTF-8";
        LC_PAPER = "fi_FI.UTF-8";
        LC_TELEPHONE = "fi_FI.UTF-8";
        LC_TIME = "fi_FI.UTF-8";
      };

      services.xserver.xkb = {
        layout = "fi";
        variant = "nodeadkeys";
      };

      console.keyMap = "fi";

      
      environment.systemPackages = with pkgs; [
        cliphist
        zip
        killall
        fzf
        htop
        btop
        fd
        vim
        git
        wget
        ripgrep
        fastfetch
        yt-dlp
        imagemagick
        unzip
        gh
        bat
        nautilus
        man
        eza
        self.packages.${pkgs.stdenv.hostPlatform.system}.kitty
      ];

      programs.fish = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.environment;
      };

      programs.yazi = {
        enable = true;
      };
    };
}
