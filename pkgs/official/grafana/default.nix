{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "mcp-grafana";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "grafana";
    repo = "mcp-grafana";
    tag = "v${version}";
    hash = "sha256-HB4xVh2yTuKVRyFujX0JVx+ni4jvImNf1CXPDxjRrN0=";
  };

  vendorHash = "sha256-GUSMJizNt0C8tx3koVFmMnJPhThYM9Fy1iGI86ZkYe0=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "MCP server for Grafana";
    homepage = "https://github.com/grafana/mcp-grafana";
    changelog = "https://github.com/grafana/mcp-grafana/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "mcp-grafana";
  };
}
