{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "youtube"; }) ];
}
