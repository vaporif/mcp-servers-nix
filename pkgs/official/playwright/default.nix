{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage rec {
  pname = "playwright-mcp";
  version = "0.0.29";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "playwright-mcp";
    tag = "v${version}";
    hash = "sha256-owSoE3+jSg09dFpM5wv7FJovzsX5ZMp/9IIQhkmSZt0=";
  };

  npmDepsHash = "sha256-jweIBhlVci8CFBIYlFp0opc1ilWMcHt0is4qgTiYNcQ=";

  meta = {
    description = "Playwright MCP server";
    homepage = "https://github.com/microsoft/playwright-mcp";
    changelog = "https://github.com/microsoft/playwright-mcp/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "mcp-server-playwright";
  };
}
