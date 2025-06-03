{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "qdrant"; }) ];
}
