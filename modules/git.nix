{ config, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      userEmail = "TDanvers@protonmail.ch";
      userName = "Tressa Danvers";
    };
  };
}
