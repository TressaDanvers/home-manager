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

  minimum-nonnix-system = target-os: target: let
    theme = lib.recursiveUpdate host-themes.${target-os} user-themes.default;
  in {
    "${target}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ (import ./hosts/generic-linux.nix theme) ];
    };
  };

  merge = lib.lists.foldr (a: b: a // b) {};
  merge-attrs = f: lib.attrsets.foldlAttrs (a: b: c: a // (f b c)) {};

  with-hostname-multi = users: host-os: host-name:
    merge (lib.lists.forEach users (with-hostname host-os host-name));

  with-hostnames-multi = users: host-os: host-names:
    merge (lib.lists.forEach host-names (with-hostname-multi users host-os));

  generic-group = users:
    merge (lib.lists.forEach users generic);

  host-group = users: hosts:
    merge-attrs (with-hostnames-multi users) hosts;

  minimum-nonnix-system-group = targets:
    merge-attrs minimum-nonnix-system targets;
in {
  merge = merge;
  generic-group = generic-group;
  host-group = host-group;
  minimum-nonnix-system-group = minimum-nonnix-system-group;
}
