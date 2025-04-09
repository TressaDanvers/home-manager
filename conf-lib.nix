{ nixpkgs, home-manager, ... }: let
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
  lib = nixpkgs.lib;

  user-themes = import ./users/themes.nix;
  host-themes = import ./hosts/themes.nix;

  generate-module = host-os: host-name: user-name: let
    theme = lib.recursiveUpdate host-themes.${host-os} user-themes.${user-name};
  in [
    (import ./hosts/${host-name}.nix theme)
    (import ./users/${user-name}.nix theme)
  ];

  generate-config = host-os: host-name: user-name: home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = generate-module host-os host-name user-name;
  };

  generic = user-name: {
    "${user-name}" = generate-config "default" "default" user-name;
  };

  with-hostname = host-os: host-name: user-name: {
    "${user-name}@${host-name}" = generate-config host-os host-name user-name;
  };

  merge = lib.lists.foldr (a: b: a // b) {};

  with-hostname-multi = users: host-os: host-name:
    merge (lib.lists.forEach users (with-hostname host-os host-name));

  with-hostnames-multi = users: host-os: host-names:
    merge (lib.lists.forEach host-names (with-hostname-multi users host-os));

  generic-group = users:
    merge (lib.lists.forEach users generic);

  host-group = users: hosts:
    lib.attrsets.foldlAttrs (a: host-os: host-names: a // (with-hostnames-multi users host-os host-names)) {} hosts;
in {
  merge = merge;
  generic-group = generic-group;
  host-group = host-group;
}
