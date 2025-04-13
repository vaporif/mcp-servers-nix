{
  pkgs ? import <nixpkgs> { },
}:
let
  inherit (pkgs) lib;
in
lib.mergeAttrsList (
  map (test: import (./. + "/${test}") { inherit pkgs; }) (
    builtins.filter (file: (lib.hasSuffix ".nix" file) && (file != "default.nix")) (
      builtins.attrNames (builtins.readDir ./.)
    )
  )
)
