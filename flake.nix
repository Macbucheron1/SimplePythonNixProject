{
  description = "Un flake Nix très basique pour une app Python";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      myApp = pkgs.python3Packages.buildPythonApplication {
        pname = "basic_python_app";
        version = "0.1.0";
        src = ./.;
      };
    in {
      packages.${system} = {

        # Image par défaut, le binaire
        default = myApp;

        # Image docker
        container = pkgs.dockerTools.buildImage {
          name = "basic_python_app";
          tag = "latest";
          copyToRoot = [ myApp ];
          config = {
            Cmd = [ "${myApp}/bin/basic_python_app" ];
          };
        };
      };
    };
}