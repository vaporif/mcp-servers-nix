{ fetchFromGitHub }:
rec {
  version = "2025.8.4";
  src = fetchFromGitHub {
    owner = "modelcontextprotocol";
    repo = "servers";
    tag = version;
    hash = "sha256-wD0OToLGy9Jyid4PaC8+dqAkIhDQY0c9CT7gcTLMz2Y=";
  };
}
