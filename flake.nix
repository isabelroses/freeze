{
  description = "A tool for generating images of code and terminal output";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

  outputs = {nixpkgs, ...}: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "x86_64-darwin" "i686-linux" "aarch64-linux" "aarch64-darwin"];

    pkgsForEach = nixpkgs.legacyPackages;
  in {
    packages = forAllSystems (system: {
      default = pkgsForEach.${system}.callPackage ./default.nix {};
    });

    overlays.default = final: _: {
      freeze = final.callPackage ./default.nix {};
    };
  };
}
