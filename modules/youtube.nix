{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "youtube"; packageName = "mcp-youtube";}) ];
}
