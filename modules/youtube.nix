{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "youtube"; packageName = "youtube"; }) ];
}
