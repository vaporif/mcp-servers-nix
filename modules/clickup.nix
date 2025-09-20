{
  config,
  lib,
  mkServerModule,
  ...
}:
let
  cfg = config.programs.clickup;
in
{
  imports = [
    (mkServerModule {
      name = "clickup";
      packageName = "clickup-mcp-server";
    })
  ];

  options.programs.clickup = {
    enabledTools = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [
        "create_task"
        "get_task"
        "update_task"
        "get_workspace_hierarchy"
      ];
    };
  };

  config.settings.servers = lib.mkIf cfg.enable {
    clickup = {
      env = {
        ENABLED_TOOLS = lib.escapeShellArg (lib.concatStringsSep "," cfg.enabledTools);
      };
    };
  };
}
