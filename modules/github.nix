{
  config,
  lib,
  servers,
  mkServerModule,
  ...
}:
let
  cfg = config.programs.github;
in
{
  imports = [
    (mkServerModule {
      name = "github";
      packageName = "github-mcp-server";
    })
  ];

  config.settings.servers = lib.mkIf cfg.enable {
    github = {
      args = lib.optional (cfg.package == servers.github-mcp-server) "stdio";
    };
  };
}
