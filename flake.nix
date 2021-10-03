{
  description = "purescript-unsafe-coerce";

  inputs.purenix.url = "github:purenix-org/purenix";
  inputs.nixpkgs.follows = "purenix/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, purenix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlay = self: _: {
          purenixShell = self.mkShell {
            packages = [
              self.purescript
              purenix.defaultPackage.${system}
              self.spago
            ];
          };
        };
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            overlay
          ];
        };
      in
      {
        devShell = pkgs.purenixShell;
        purenix = purenix;
      }
    );
}

