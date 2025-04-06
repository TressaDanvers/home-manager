theme: { ... }: {
  imports = [ (import ./default.nix theme) ];

  home = {
    username = "root";
    homeDirectory = "/root";
  };

  programs.git = {
    userEmail = "TDanvers@protonmail.ch";
    userName = "Tressa Danvers";
  };
}
