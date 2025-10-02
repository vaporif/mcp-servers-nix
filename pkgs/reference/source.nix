{ fetchFromGitHub }:
rec {
  version = "2025.9.25";
  src = fetchFromGitHub {
    owner = "modelcontextprotocol";
    repo = "servers";
    tag = version;
    hash = "sha256-ysTuSHFs7GABMuFXG+DcyonVXVs7m45j9sDPdHBS2wQ=";
  };
}
