{ callPackage, python3Packages, lib }:
let
  pythonDeps = (import ../../../lib).mkPythonDeps { inherit lib python3Packages; fetchPypi = python3Packages.fetchPypi; };
in
callPackage ../../reference/generic-python.nix {
  service = "qdrant";
  dependencies = with python3Packages; [
    mcp
    pydantic
    tzdata
    fastembed
    qdrant-client
  ] ++ [ pythonDeps.fastmcp ];
  doCheck = false;
}
