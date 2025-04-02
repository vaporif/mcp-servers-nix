{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "gdrive"; }) ];
}
