{ callPackage, python3Packages }:
callPackage ./generic-python.nix {
  service = "git";
  dependencies = with python3Packages; [
    click
    gitpython
    mcp
    pydantic
  ];
}
