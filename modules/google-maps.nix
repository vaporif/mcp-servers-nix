{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "google-maps"; }) ];
}
