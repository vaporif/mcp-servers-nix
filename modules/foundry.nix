{ mkServerModule, ... }:
{
  imports = [
    (mkServerModule {
      name = "foundry";
      packageName = "foundry-mcp-server";
    })
  ];
}
