{ fetchFromGitHub }:
rec {
  version = "2025.4.24";
  src = fetchFromGitHub {
    owner = "modelcontextprotocol";
    repo = "servers";
    tag = version;
    hash = "sha256-GCxzgvpd09Cw/2Ae2wTkEDBIWdi492SzuA8zIA6dGgQ=";
  };
}
