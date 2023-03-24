{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };
    purifix = {
      url = "github:purifix/purifix";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    nix-eval-jobs = {
      url = "github:nix-community/nix-eval-jobs";
    };
    nix-build-results = {
      url = "github:considerate/nix-build-results";
    };
    purenix.url = "github:purenix-org/purenix";
  };
  outputs = inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            inputs.purifix.overlay
            inputs.purenix.overlay
            inputs.nix-build-results.overlay
          ];
        };
        purenix-pkgs = pkgs.purifix {
          src = ./.;
          backends = [ pkgs.purenix ];
          withDocs = false;
          copyFiles = true;
        };
        all-packages = pkgs.linkFarmFromDrvs "purenix-pkgs" (builtins.attrValues purenix-pkgs);
        package-set = pkgs.linkFarmFromDrvs "purenix-package-set" (builtins.attrValues purenix-pkgs.prelude.package-set);
        drvs = pkgs.lib.mapAttrs (_: pkg: { inherit (pkg) drvPath version; }) purenix-pkgs.prelude.package-set;
      in
      {
        hello = drvs;
        packages = purenix-pkgs // { inherit all-packages package-set; };
        apps = { };
        devShells = {
          default = pkgs.stdenv.mkDerivation {
            name = "purenix-shell";
            buildInputs = [
              pkgs.python3
              pkgs.nix-build-results
            ];
          };
        };
      });
}
