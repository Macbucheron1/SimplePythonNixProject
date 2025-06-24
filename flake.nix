{
  description = "A very basic Python application using Nix flakes";

  # Define the inputs for the flake.
  inputs = {
    # Use the Nixpkgs flake for package management.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  # Define the outputs of the flake. 
  # The outputs are defined as a function that takes inputs.
  # This allows for dynamic evaluation based on the inputs.
  outputs = { self, nixpkgs }:
  
    # The let expression allows us to define local variables that can be used in after the in keyword.
    let
      # Define the system architecture.
      system = "x86_64-linux";

      # Import the Nixpkgs package set for the specified system.
      pkgs = import nixpkgs { inherit system; };

      # Define the Python version and the application package.
      python310 = pkgs.python310;

      # Define the Python application package using hatchling for building.
      # This assumes you have a basic Python project structure with a pyproject.toml.
      myApp = python310.pkgs.buildPythonPackage {
        pname = "basic_python_app";
        version = "0.1.0";
        src = ./.;
        format = "pyproject";
        nativeBuildInputs = [ python310.pkgs.hatchling ];
      };
    # End of let expression. We can now use the defined variables in let.
    # This is where we define the outputs of the flake.
    # Here we want 
    # 1. to provide a package
    # 2. a Docker image
    # 3. and a development shell
    in {
      # Define the packages output for the specified system.
      # This allows users to install the package using `nix build`.
      packages.${system} = {

        # 1. The default package is simply the Python application we defined earlier.
        default = myApp;

        # 2. Here we define a second package that builds a Docker image for the application.
        # It won't be built by default, but can be built explicitly by using `nix build .#image`.
        image = pkgs.dockerTools.buildImage {
          name = "basic_python_app";
          tag = myApp.version;
          copyToRoot = [ myApp ];
          config = {
            Cmd = [ "${myApp}/bin/basic_python_app" ];
          };
        };

        # You can add more packages here if needed. To build them, you can use `nix build .#packageName`.
      };
      
      # 3. Define the devShells output for the specified system.
      # This allows users to enter a development environment with the necessary tools.
      devShells.${system}.default = pkgs.mkShell {

        # We use buildInputs to specify the dependencies needed in the development shell.
        # This includes the Python interpreter and hatchling for building the application.
        buildInputs = [
          python310
          python310.hatchling
        ];
      };
    };
}