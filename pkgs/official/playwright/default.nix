{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
  versionCheckHook,
}:

buildNpmPackage rec {
  pname = "playwright-mcp";
  version = "0.0.47";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "playwright-mcp";
    tag = "v${version}";
    hash = "sha256-Ksc/lnhMuvu4ykJvgKQSCpWvtLvolwauxXYsLNcQV4g=";
  };

  npmDepsHash = "sha256-r+fbb1WQH6ovHSmzxbgEouCJux4ipqRedtblLEC3Agg=";

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
