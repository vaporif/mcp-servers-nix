{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage rec {
  pname = "clickup-mcp-server";
  version = "0.8.5";

  src = fetchFromGitHub {
    owner = "taazkareem";
    repo = "clickup-mcp-server";
    tag = "v${version}";
    hash = "sha256-qMjFX6RXVVNKY+1CN7dR7N9eyrtBLhY2ag1rQr9S3BU=";
  };

  patches = [ ./use-tmpdir-for-logs.patch ];

  npmDepsHash = "sha256-I/62Z10NCIrqnp7cvUZZ5mQZgM5mZOCg8DuS5xXP17g=";

  meta = {
    description = "Integrate ClickUp project management with AI through Model Context Protocol";
    homepage = "https://github.com/taazkareem/clickup-mcp-server";
    changelog = "https://github.com/taazkareem/clickup-mcp-server/blob/${src.tag}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "clickup-mcp-server";
  };
}
