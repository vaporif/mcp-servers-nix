{ mkServerModule, ... }:
{
  imports = [ (mkServerModule { name = "puppeteer"; }) ];
}
