{ config, pkgs, ... }:

{
  imports = [ ./../../modules/git-configuration.nix ./../../modules/bash-configuration.nix ];

  home = {
    stateVersion = "24.05";

    username = "tressa";
    homeDirectory = "/home/tressa";

    sessionVariables = { EDITOR = "nano"; };
  };

  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;
}
