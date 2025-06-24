{
  description = "Un flake Nix très basique pour une app Python";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      myApp = pkgs.python3.pkgs.buildPythonPackage {
        pname = "basic_python_app"; 
        version = "0.1.0";
        src = ./.;
        format = "pyproject";
        nativeBuildInputs = [ pkgs.python3Packages.hatchling ];
      };
    in {
      packages.${system} = {

        default = myApp;

        container = pkgs.dockerTools.buildImage {
          name = "basic_python_app";
          tag = "latest";
          copyToRoot = [ myApp ];
          config = {
            Cmd = [ "${myApp}/bin/basic_python_app" ];
          };
        };
      };
      
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.python3
          pkgs.python3Packages.hatchling
        ];
      };
    };
}