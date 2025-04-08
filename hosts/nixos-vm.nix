theme: { config, pkgs, ... }: {
  imports = [ (import ./default.nix theme) ];
  targets.genericLinux.enable = true;
}
