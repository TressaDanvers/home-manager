theme: { config, pkgs, ... }: {
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
