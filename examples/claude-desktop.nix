{
  pkgs ? import <nixpkgs> { },
}:
let
  mcp-servers = import ../. { inherit pkgs; };
in
mcp-servers.lib.mkConfig pkgs {
  programs = {
    filesystem = {
      enable = true;
      args = [ "/path/to/allowed/directory" ];
    };
    github = {
      enable = true;
      envFile = ./dummy-gh-token;
    };
  };
}
