{ callPackage, python3Packages }:
callPackage ./generic-python.nix {
  service = "sqlite";
  dependencies = with python3Packages; [
    mcp
  ];
  doCheck = false;
}
