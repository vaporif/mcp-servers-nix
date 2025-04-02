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

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-4lJCHDxVG/Ja0jo3sXuY/H01fwGcxlabc8GNPgKAnRY=";

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
