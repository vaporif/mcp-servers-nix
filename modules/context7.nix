{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "context7"; }) ];
}
