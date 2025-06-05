{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage {
  pname = "tavily-mcp-server";
  version = "1.8.1";

  src = fetchFromGitHub {
    owner = "tavily-ai";
    repo = "tavily-mcp";
    rev = "1fed0f52655601aaca254a8e7497d45c40cd9a74";
    hash = "sha256-+GahPtLVNRKmzTebMheiFYCbsERwnBjWHB5uAogjnic=";
  };

  npmDepsHash = "sha256-LMz9YuUZ39MoMPkyajmJ5D38l/fz88qBYsuK5poI10k=";

  meta = {
    description = "Official Tavily MCP Server";
    homepage = "https://github.com/tavily-ai/tavily-mcp";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ vaporif ];
    mainProgram = "tavily-mcp";
  };
}
