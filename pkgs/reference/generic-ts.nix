{
  service,
  workspace ? service,
}:
{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
  typescript,
  writeScriptBin,
}:
buildNpmPackage {
  pname = "mcp-server-${service}";
  inherit (import ./source.nix { inherit fetchFromGitHub; }) version src;

  npmDepsHash = "sha256-qIsj4XCMqFxqsfjZzs/eDM57U+BI3yJ6h6sdMHXgLvU=";

  npmWorkspace = "src/${workspace}";

  env.PUPPETEER_SKIP_DOWNLOAD = true;

  nativeBuildInputs = [
    typescript
    (writeScriptBin "shx" "")
  ];

  dontCheckForBrokenSymlinks = true;

  meta = {
    description = "Model Context Protocol Servers for ${service}";
    homepage = "https://github.com/modelcontextprotocol/servers";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "mcp-server-${service}";
  };
}
