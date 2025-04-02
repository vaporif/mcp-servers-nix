{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "sentry"; }) ];
}
