{ config, pkgs, ... }:

{
  imports = [ ./../modules/git.nix ];

  home = {
    stateVersion = "24.05";

    username = "tressa";
    homeDirectory = "/home/tressa";

    packages = with pkgs; [ tree ];

    sessionVariables = { EDITOR = "nano"; };
  };

  programs.home-manager.enable = true;
}
