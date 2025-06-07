{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
  jq,
}:
buildNpmPackage rec {
  pname = "mcp-youtube";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "icraft2170";
    repo = "youtube-data-mcp-server";
    rev = "main";
    hash = "sha256-/AkXWYU5MfeJWsPnLOoY+TiwXJSApXuKRuK4a2ziJiM=";
  };

  npmDepsHash = "sha256-QmRyVyt+OvcadnKP/6sJfSXDlkFrGN2t8r4JsA6a+eM=";

  npmBuildScript = "build";

  postPatch = ''
    # Remove postinstall script that tries to chmod dist/index.js before it exists
    ${lib.getExe jq} 'del(.scripts.postinstall)' package.json > package.json.tmp
    mv package.json.tmp package.json
  '';

  postInstall = ''
    chmod +x $out/lib/node_modules/youtube-data-mcp-server/dist/index.js

    mkdir -p $out/bin
    ln -s $out/lib/node_modules/youtube-data-mcp-server/dist/index.js $out/bin/mcp-youtube-server
  '';

  meta = {
    description = "YouTube Data MCP Server";
    homepage = "https://github.com/icraft2170/youtube-data-mcp-server";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ vaporif ];
    mainProgram = "youtube-data-mcp-server";
  };
}
