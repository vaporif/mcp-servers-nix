{ callPackage, python3Packages }:
callPackage ./generic-python.nix {
  service = "sentry";
  dependencies = with python3Packages; [
    mcp
  ];
  doCheck = false;
}
