{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "github-mcp-server";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "github";
    repo = "github-mcp-server";
    tag = "v${version}";
    hash = "sha256-4OdDTis4vRPqzAVYm8TuFHlW1+1FdQbIdjNNeTVuuMw=";
  };

  vendorHash = "sha256-DeojCgMBwVclvoiEs462FoxIf3700XUjXvPbvRZE3CI=";

  ldflags = [
    "-s"
    "-w"
    "-X=main.version=${version}"
    "-X=main.commit=${src.rev}"
    "-X=main.date=1970-01-01T00:00:00Z"
  ];

  __darwinAllowLocalNetworking = true;

  meta = {
    description = "GitHub's official MCP Server";
    homepage = "https://github.com/github/github-mcp-server";
    changelog = "https://github.com/github/github-mcp-server/releases/tag/v${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "github-mcp-server";
  };
}
