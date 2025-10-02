{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "mcp-grafana";
  version = "0.7.2";

  src = fetchFromGitHub {
    owner = "grafana";
    repo = "mcp-grafana";
    tag = "v${version}";
    hash = "sha256-LJbH4g3RhqziU+kL+O/cmHnCkH0xiVHb8+qOdrO6/5o=";
  };

  vendorHash = "sha256-W33myluCqCt1QHU+Fpd954Gxvum8ktQ/IZODxaFhk/k=";

  ldflags = [
    "-s"
    "-w"
  ];

  __darwinAllowLocalNetworking = true;

  meta = {
    description = "MCP server for Grafana";
    homepage = "https://github.com/grafana/mcp-grafana";
    changelog = "https://github.com/grafana/mcp-grafana/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "mcp-grafana";
  };
}
