{ config, pkgs, ... }:

{
  programs = {
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    git = {
      enable = true;
      userEmail = "TDanvers@protonmail.ch";
      userName = "Tressa Danvers";
    };
  };
}
