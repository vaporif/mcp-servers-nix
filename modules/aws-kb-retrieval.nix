{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "aws-kb-retrieval"; }) ];
}
