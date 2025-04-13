{
  description = "tressa user configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: with (import ./conf-lib.nix inputs); {
    homeConfigurations = merge [
      ## Generic User Group
      (generic-group [ "root" "tressa" ])

      ## Virtual Machine Group
      (host-group [ "root" "tressa" ] {
        arch     = [ "arch-vm"     ];
        debian   = [ "debian-vm"   ];
        fedora   = [ "fedora-vm"   ];
        nixos    = [ "nixos-vm"    ];
        openSUSE = [ "opensuse-vm" ];
      })
    ];
  };
}
