{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage rec {
  pname = "notion-mcp-server";
  version = "1.8.1";

  src = fetchFromGitHub {
    owner = "tavily-ai";
    repo = pname;
    rev = "1fed0f52655601aaca254a8e7497d45c40cd9a74";
    hash = "sha256-s+N3iaERCk2coEw+I/rsMJhGJ5XYA8FMrDgCoTZmb/A=";
  };

  npmDepsHash = "sha256-u8sox/qbb3bdPcGPSNI9124DL3djDmQ8xHOagrl1GGA=";

  meta = {
    description = "Official Tavily MCP Server";
    homepage = "https://github.com/tavily-ai/tavily-mcp";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ vaporif ];
    mainProgram = "tavily-mcp-server";
  };
}
