{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "postgres"; }) ];
}
