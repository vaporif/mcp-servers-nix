{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
  versionCheckHook,
}:

buildNpmPackage rec {
  pname = "playwright-mcp";
  version = "0.0.51";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "playwright-mcp";
    tag = "v${version}";
    hash = "sha256-uw/9KIBnvBX1uQpCHEG8o7YgraThGOuOSJLUUSTQs2A=";
  };

  npmDepsHash = "sha256-jTIBeKQm7oEb09TVo7+mWQFQ+ODZHCTZ1Qreh5sAiWk=";

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
