{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage {
  pname = "notion-mcp-server";
  version = "1.6.0";

  src = fetchFromGitHub {
    owner = "makenotion";
    repo = "notion-mcp-server";
    rev = "5771f71ddbe932e2eb4f37d7fd8700a55d51b6d0";
    hash = "sha256-nZb7iJ3EjahTcLeBckEJWaqnxlQtsuECZdRMm77juTQ=";
  };

  npmDepsHash = "sha256-WiMgekr2mBJHAIS1AJ8f+rKzpboFcCylXRcUuUl54VQ=";

  meta = {
    description = "Official Notion MCP Server";
    homepage = "https://github.com/makenotion/notion-mcp-server";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "notion-mcp-server";
  };
}
