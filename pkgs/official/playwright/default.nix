{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage rec {
  pname = "playwright-mcp";
  version = "0.0.20";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "playwright-mcp";
    tag = "v${version}";
    hash = "sha256-N5Lm4FuErJsZLYhRJ+GNQsVseuEZWMBJX7yURiBDBZY=";
  };

  npmDepsHash = "sha256-c64JELBEpIxzKhKNSKUwlujQhLPvhU0E/GVSi6+d5jE=";

  meta = {
    description = "Playwright MCP server";
    homepage = "https://github.com/microsoft/playwright-mcp";
    changelog = "https://github.com/microsoft/playwright-mcp/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "mcp-server-playwright";
  };
}
