# Simple Python & Nix project

This repo is here to demonstrate how to setup a simple python project & control it using nix

## Why use nix ?

Nix is a language that act as declarative package manager. By using nix you more easely control the reproducibility of your package.

## Useful command

Here are some useful command

### Developpment 

When developping your package you can enter the dev shell using:
```nix
nix develop
```

### Building
To build your package you can use the nix command
```nix
nix build
```
As a resultat you will obtain a symlink named `result`
```
.
├── basic_python_app
│   ├── __init__.py
│   └── __main__.py
├── flake.lock
├── flake.nix
├── pyproject.toml
├── README.md
└── result -> /nix/store/azf1c256zvqmd3x185yya8mvsah386al-python3.11-basic_python_app-0.1.0
```

### Run 

You can run your package using the nix command
```nix
nix run
```