{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "sqlite"; }) ];
}
