{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage rec {
  pname = "deepl-mcp-server";
  version = "1.0.1-unstable-2025-12-11";

  src = fetchFromGitHub {
    owner = "DeepLcom";
    repo = "deepl-mcp-server";
    rev = "0099c19386bce816c55e441c5e05d28968dd0d3b";
    hash = "sha256-9w9Pk5uncyjvgK6wlfqk+Ema2AsCWBzKt+DKgZJW+n4=";
  };

  npmDepsHash = "sha256-4zDEx3qPDUnYkYCwoWlSjTBeFo2B2TIfOBQc2olGtPo=";

  dontNpmBuild = true;

  meta = {
    description = "MCP server for DeepL translation API";
    homepage = "https://github.com/DeepLcom/deepl-mcp-server";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "deepl-mcp-server";
  };
}
