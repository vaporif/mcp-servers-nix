{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "github-mcp-server";
  version = "0.20.2";

  src = fetchFromGitHub {
    owner = "github";
    repo = "github-mcp-server";
    tag = "v${version}";
    hash = "sha256-1xr0AUAfYrxR7koCn9S3VJAw8PaJvFLNyzsblqyGyC0=";
  };

  vendorHash = "sha256-j0THkLxOcNTyUoyl3WkbjR+8urM4fmsg7Mt74S4wjqU=";

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
