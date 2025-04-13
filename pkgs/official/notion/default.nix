{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage {
  pname = "notion-mcp-server";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "makenotion";
    repo = "notion-mcp-server";
    rev = "649695e5494879e2c1f200dcb3ce02080023095d";
    hash = "sha256-AO6/gDl/RZyRLnyb03Kpt8JvlgMmtULMcp5bQpmrazA=";
  };

  npmDepsHash = "sha256-Y4qD5Z4sDO82cIk3q+LzRFEpB27WpkKPR9si85yodFI=";

  meta = {
    description = "Official Notion MCP Server";
    homepage = "https://github.com/makenotion/notion-mcp-server";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "notion-mcp-server";
  };
}
