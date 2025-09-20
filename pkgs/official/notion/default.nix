{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage {
  pname = "notion-mcp-server";
  version = "1.9.0";

  src = fetchFromGitHub {
    owner = "makenotion";
    repo = "notion-mcp-server";
    rev = "ffc1b18807df0cd72717f6ba55e7866af2d91ccd";
    hash = "sha256-e1OHix3fJ2LKgdOML6LMQOb6573VMr0g/1AA/3Izu74=";
  };

  npmDepsHash = "sha256-d+C5twhyH0ZQFI0/n7R3jPU864yFgD9Cni2Qu3dahjc=";

  meta = {
    description = "Official Notion MCP Server";
    homepage = "https://github.com/makenotion/notion-mcp-server";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "notion-mcp-server";
  };
}
