{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "everart"; }) ];
}
