theme: { ... }: {
  imports = [ (import ./default.nix theme) ];

  home = {
    username = "tressa";
    homeDirectory = "/home/tressa";
  };

  programs.git = {
    userEmail = "TDanvers@protonmail.ch";
    userName = "Tressa Danvers";
  };
}
