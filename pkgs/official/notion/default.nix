{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage {
  pname = "notion-mcp-server";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "makenotion";
    repo = "notion-mcp-server";
    rev = "e55be1e9e99fbe3196d35944db144e905d056713";
    hash = "sha256-AqRrPBVbZ9QduU1M4Vogja4jEshMFvt69zh+x/1PAuo=";
  };

  npmDepsHash = "sha256-cJT0Kg04lLFBqp/SdYuECOTmDPGRwCuHjvRImAhC6GU=";

  meta = {
    description = "Official Notion MCP Server";
    homepage = "https://github.com/makenotion/notion-mcp-server";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "notion-mcp-server";
  };
}
