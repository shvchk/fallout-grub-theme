{
  description = "Fallout GRUB theme";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };

        fallout-grub-theme = let
          name = "fallout-grub-theme";
        in
          pkgs.stdenv.mkDerivation {
            inherit name;
            src = builtins.path {
              inherit name;
              path = ./.;
            };

            installPhase = ''
              mkdir -p $out
              cp -r $src/* $out
            '';
          };
      in rec {
        defaultPackage = fallout-grub-theme;
        defaultApp = flake-utils.lib.mkApp {
          drv = defaultPackage;
        };
      }
    );
}
