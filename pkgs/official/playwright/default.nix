{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage rec {
  pname = "playwright-mcp";
  version = "0.0.28";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "playwright-mcp";
    tag = "v${version}";
    hash = "sha256-3FWU+s+E9Gxyp1UryVYMw+MSWoMjNR/V2PLqk85jct4=";
  };

  npmDepsHash = "sha256-R+M9RZ9BBggeQjYPV95C7Qj3zwg+LkLF/PZN8CcROkQ=";

  meta = {
    description = "Playwright MCP server";
    homepage = "https://github.com/microsoft/playwright-mcp";
    changelog = "https://github.com/microsoft/playwright-mcp/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "mcp-server-playwright";
  };
}
