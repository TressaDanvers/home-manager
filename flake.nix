{
  description = "tressa user configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    user-themes = import ./users/themes.nix;
    host-themes = import ./hosts/themes.nix;
  in {
    homeConfigurations = {
      "tressa@debian-vm" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = let 
          theme = nixpkgs.lib.recursiveUpdate host-themes.debian user-themes.tressa;
        in [
          (import ./hosts/debian-vm.nix theme)
          (import ./users/tressa.nix theme)
        ];
      };

      "root@debian-vm" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = let 
          theme = nixpkgs.lib.recursiveUpdate host-themes.debian user-themes.root;
        in [
          (import ./hosts/debian-vm.nix theme)
          (import ./users/root.nix theme)
        ];
      };

      "tressa@arch-vm" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = let 
          theme = nixpkgs.lib.recursiveUpdate host-themes.arch user-themes.tressa;
        in [
          (import ./hosts/arch-vm.nix theme)
          (import ./users/tressa.nix theme)
        ];
      };

      "tressa@fedora-vm" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = let 
          theme = nixpkgs.lib.recursiveUpdate host-themes.fedora user-themes.tressa;
        in [
          (import ./hosts/fedora-vm.nix theme)
          (import ./users/tressa.nix theme)
        ];
      };

      "tressa@opensuse-vm" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = let 
          theme = nixpkgs.lib.recursiveUpdate host-themes.suse user-themes.tressa;
        in [
          (import ./hosts/opensuse-vm.nix theme)
          (import ./users/tressa.nix theme)
        ];
      };
    };
  };
}
