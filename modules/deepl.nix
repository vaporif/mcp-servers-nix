{ mkServerModule, ... }:
{
  imports = [
    (mkServerModule {
      name = "deepl";
      packageName = "deepl-mcp-server";
    })
  ];
}
