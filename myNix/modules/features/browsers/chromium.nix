{ self, inputs, ... }:
{
  flake.nixosModules.chromium =
    { pkgs, lib, ... }:
    {
      programs.chromium = {
        enable = true;
        extraOpts = {
            "BraveAIChatEnabled" = false; # Disable Brave AI Chat
            "BraveNewsDisabled" = true; # Disable Brave News
            "BraveRewardsDisabled" = true; # Disable Brave Rewards
            "BraveStatsPingEnabled" = false;
            "BraveTalkDisabled" = true; # Disable Brave Talk
            "BraveVPNDisabled" = true; # Disable Brave VPN
            "BraveWalletDisabled" = true; # Disable Brave Wallet
            "BraveP3AEnabled" = false;
            "BravePlaylistEnabled" = false;
        };
        extensions = [
          "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
          "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
        ];
      };

      environment.systemPackages = [
        pkgs.brave
      ];
    };
}
