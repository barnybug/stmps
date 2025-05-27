{
  description = "stmps flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        # System specific outputs becomes: packages.<system>.default
        packages.default = pkgs.buildGoModule {
          pname = "stmps";
          version = "0.0.1";
          src = ./.;
          vendorHash = "sha256-nQ+njG45mYJ6lkGPOsEe+ob4EXvIoJ2d+cFXZSM3Lls=";
          buildInputs = [pkgs.mpv];
        };
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [go mpv];
        };
      }
    );
}
