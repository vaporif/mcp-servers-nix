{ callPackage, python3Packages }:
callPackage ./generic-python.nix {
  service = "time";
  dependencies = with python3Packages; [
    mcp
    pydantic
    tzdata
  ];
  doCheck = false;
}
