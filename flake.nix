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
  };
  outputs = inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ inputs.purifix.overlay ];
        };
        purenix-pkgs = pkgs.purifix {
          src = ./.;
        };
      in
      {
        packages = {
          default = purenix-pkgs;
        };
        defaultPackage = purenix-pkgs;
      });
}
