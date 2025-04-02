{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "slack"; }) ];
}
