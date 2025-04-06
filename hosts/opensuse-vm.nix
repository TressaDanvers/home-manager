theme: { config, pkgs, ... }: {
  imports = [ (import ./default.nix theme) ];
  programs.fastfetch.settings.logo.source = "opensuse";
  targets.genericLinux.enable = true;
}
