{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage {
  pname = "notion-mcp-server";
  version = "1.8.1";

  src = fetchFromGitHub {
    owner = "makenotion";
    repo = "notion-mcp-server";
    rev = "e973d503f7240d2aa6e5422f5589b34839382716";
    hash = "sha256-s+N3iaERCk2coEw+I/rsMJhGJ5XYA8FMrDgCoTZmb/A=";
  };

  npmDepsHash = "sha256-u8sox/qbb3bdPcGPSNI9124DL3djDmQ8xHOagrl1GGA=";

  meta = {
    description = "Official Notion MCP Server";
    homepage = "https://github.com/makenotion/notion-mcp-server";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "notion-mcp-server";
  };
}
