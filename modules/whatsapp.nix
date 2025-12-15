{ mkServerModule, ... }:
{
  imports = [
    (mkServerModule {
      name = "whatsapp";
      packageName = "whatsapp-mcp-server";
    })
  ];
}
