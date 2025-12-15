{ mkServerModule, ... }:
{
  imports = [
    (mkServerModule {
      name = "whatsapp-mcp";
      packageName = "whatsapp-mcp-server";
    })
  ];
}
