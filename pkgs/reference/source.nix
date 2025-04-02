{ fetchFromGitHub }:
rec {
  version = "2025.3.28";
  src = fetchFromGitHub {
    owner = "modelcontextprotocol";
    repo = "servers";
    tag = version;
    hash = "sha256-6362x1vFLDMvcPNeS91juO/nZB51el48zOamIQrSeZw=";
  };
}
