{ config, pkgs, ... }:

{
  home = {
    stateVersion = "24.05";

    username = "tressa";
    homeDirectory = "/home/tressa";

    sessionVariables = { EDITOR = "nano"; };
  };

  programs = {
    git = {
      enable = true;
      userEmail = "TDanvers@protonmail.ch";
      userName = "Tressa Danvers";
    };

    home-manager.enable = true;
  };
}
