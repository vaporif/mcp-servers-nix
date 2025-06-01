{ mkServerModule, ... }:
{
  imports = [ (mkServerModule {
    name = "context7";
    packageName = "mcp-context7";
  }) ];
}
