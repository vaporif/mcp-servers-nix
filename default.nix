{
  pkgs ? import <nixpkgs> { },
}:
let
  packages = import ./pkgs { inherit pkgs; };
in
{
  lib = import ./lib;
  inherit packages;
}
// packages
