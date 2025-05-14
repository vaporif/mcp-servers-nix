{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage rec {
  pname = "playwright-mcp";
  version = "0.0.25";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "playwright-mcp";
    tag = "v${version}";
    hash = "sha256-+kMAuwIGvJF/yhxMCRNv63ft5nWdGa5DSRw4ch4kxuA=";
  };

  npmDepsHash = "sha256-ZZhc30KK4olwG4RAwRocxPmkLgXOE8XG67OvIIEyiFo=";

  meta = {
    description = "Playwright MCP server";
    homepage = "https://github.com/microsoft/playwright-mcp";
    changelog = "https://github.com/microsoft/playwright-mcp/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "mcp-server-playwright";
  };
}
