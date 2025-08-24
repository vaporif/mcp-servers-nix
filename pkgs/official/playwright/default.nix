{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage rec {
  pname = "playwright-mcp";
  version = "0.0.35";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "playwright-mcp";
    tag = "v${version}";
    hash = "sha256-bF/F4dP2ri09AlQLItQwQxDAQybY2fXft4ccxSKijt8=";
  };

  npmDepsHash = "sha256-xSQCs6rJlUrdS8c580mo1/VjpcDxwHor0pdstB9VQEo=";

  meta = {
    description = "Playwright MCP server";
    homepage = "https://github.com/microsoft/playwright-mcp";
    changelog = "https://github.com/microsoft/playwright-mcp/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "mcp-server-playwright";
  };
}
