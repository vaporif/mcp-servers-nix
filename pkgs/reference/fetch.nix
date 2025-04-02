{ callPackage, python3Packages }:
callPackage ./generic-python.nix {
  service = "fetch";
  dependencies = with python3Packages; [
    markdownify
    mcp
    protego
    pydantic
    readabilipy
    requests
  ];
  doCheck = false;
}
