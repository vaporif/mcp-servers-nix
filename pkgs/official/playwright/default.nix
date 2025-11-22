{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
  versionCheckHook,
}:

buildNpmPackage rec {
  pname = "playwright-mcp";
  version = "0.0.48";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "playwright-mcp";
    tag = "v${version}";
    hash = "sha256-LqQMTVzcMZeUswDSVz+Ib0UnKP4rv35SghmZwJ9pQqI=";
  };

  npmDepsHash = "sha256-f3DxVDdivKzBR5PC3UNCxlgfRz01OAykU5aTr2YF0XQ=";

  dontNpmBuild = true;

  doInstallCheck = true;
  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgramArg = "--version";

  meta = {
    description = "Playwright MCP server";
    homepage = "https://github.com/microsoft/playwright-mcp";
    changelog = "https://github.com/microsoft/playwright-mcp/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "mcp-server-playwright";
  };
}
