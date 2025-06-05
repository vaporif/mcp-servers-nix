{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "tavily"; packageName = "mcp-tavily"; }) ];
}
