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
          ];
        };
        purenix-pkgs = pkgs.purifix {
          src = ./.;
          backends = [ pkgs.purenix ];
          withDocs = false;
          copyFiles = true;
        };
        all-packages = pkgs.linkFarmFromDrvs "purenix-pkgs" (builtins.attrValues purenix-pkgs);
        package-set = purenix-pkgs.prelude.package-set;
      in
      {
        packages = purenix-pkgs // { inherit all-packages package-set; };
        checks = purenix-pkgs.prelude.package-set;
      });
}
