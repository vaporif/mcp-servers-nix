{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "gitlab"; }) ];
}
