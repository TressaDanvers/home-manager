{ config, pkgs, ... }:

{
  imports = [ ./../modules/git.nix ./../modules/bash.nix ];

  home = {
    stateVersion = "24.05";

    username = "tressa";
    homeDirectory = "/home/tressa";

    packages = with pkgs; [ tree ];

    sessionVariables = { EDITOR = "nano"; };
  };

  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;
}
