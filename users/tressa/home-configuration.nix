{ config, pkgs, ... }:

{
  imports = [
    ./../../modules/bash-configuration.nix
    ./../../modules/git-configuration.nix
    ./../../modules/xdg-configuration.nix
  ];

  home = {
    stateVersion = "24.05";

    username = "tressa";
    homeDirectory = "/home/tressa";

    sessionVariables = { EDITOR = "nano"; };
  };

  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;
}
