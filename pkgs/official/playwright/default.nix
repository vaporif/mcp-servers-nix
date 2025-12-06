{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
  versionCheckHook,
}:

buildNpmPackage rec {
  pname = "playwright-mcp";
  version = "0.0.50";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "playwright-mcp";
    tag = "v${version}";
    hash = "sha256-F2u3GEbTXiS8o/r8GyGFA9qcDvfr4GL0Qwd2i9camMY=";
  };

  npmDepsHash = "sha256-+l8tjcy2eyBp7S3mRAMeDLGS9QbyXchgypxjYaJFaME=";

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
