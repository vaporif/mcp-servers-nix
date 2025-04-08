{ fetchFromGitHub }:
rec {
  version = "2025.4.6";
  src = fetchFromGitHub {
    owner = "modelcontextprotocol";
    repo = "servers";
    tag = version;
    hash = "sha256-llhUxNdswL9jpBIMNliyaC0zmgkEqzLnSboQkgjgMzw=";
  };
}
