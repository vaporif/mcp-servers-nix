{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "brave-search"; }) ];
}
