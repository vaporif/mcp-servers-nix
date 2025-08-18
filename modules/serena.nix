{
  config,
  lib,
  mkServerModule,
  ...
}:
let
  cfg = config.programs.serena;
in
{
  imports = [
    (mkServerModule {
      name = "serena";
      packageName = "serena";
    })
  ];

  config.settings.servers = lib.mkIf cfg.enable {
    serena = {
      args = [ "start-mcp-server" ];
    };
  };
}
