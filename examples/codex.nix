{
  pkgs ? import <nixpkgs> { },
}:
let
  mcp-servers = import ../. { inherit pkgs; };
  config = mcp-servers.lib.mkConfig pkgs {
    flavor = "codex";
    format = "toml-inline";
    fileName = ".mcp.toml";
    programs = {
      github = {
        enable = true;
        envFile = ./dummy-gh-token;
      };
    };
  };
in
pkgs.symlinkJoin {
  name = "codex";
  paths = [ pkgs.codex ];
  nativeBuildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/codex "--add-flags" "-c '$(cat ${config})'"
  '';
}
