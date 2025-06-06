{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "mcp-youtube"; packageName = "mcp-youtube"; }) ];
}
