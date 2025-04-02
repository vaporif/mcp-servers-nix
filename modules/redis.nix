{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "redis"; }) ];
}
