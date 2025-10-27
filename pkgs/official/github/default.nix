{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "github-mcp-server";
  version = "0.20.1";

  src = fetchFromGitHub {
    owner = "github";
    repo = "github-mcp-server";
    tag = "v${version}";
    hash = "sha256-gB2MXeQQjVP/b+3hne6Mauork5szSOFz4uWIGzecN+U=";
  };

  vendorHash = "sha256-DcRpKFsCdGV3sOVHeyZbo/djVVBkuxRgFh7Z5yyElRw=";

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
