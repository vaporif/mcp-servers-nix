{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "mcp-grafana";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "grafana";
    repo = "mcp-grafana";
    tag = "v${version}";
    hash = "sha256-UrSlQW8JizSOwpaZmslSc+xsFvGtuTD/1LA9XfXQO7Y=";
  };

  vendorHash = "sha256-akXlcP7//ZSpFgVFb5HSVJRauHy3TG5u+MEb5PGn3Po=";

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
