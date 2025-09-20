{ pkgs }:
let
  inherit (import ../lib) mkConfig;
  # Create a test configuration for codex with inline TOML
  testConfig = mkConfig pkgs {
    flavor = "codex";
    format = "toml-inline";
    fileName = ".mcp.toml";

    programs = {
      filesystem = {
        enable = true;
        args = [ "/test/path" ];
        env = {
          TEST_VAR = "test_value";
        };
      };
    };
  };
in
{
  # Disabled because codex 0.22.0 cannot yet list MCP servers from command line
  # test-codex =
  #   pkgs.runCommand "test-codex"
  #     {
  #       nativeBuildInputs = with pkgs; [
  #         codex
  #       ];
  #     }
  #     ''
  #       codex -c "$(cat ${testConfig})" mcp list | grep -e filesystem > $out
  #     '';
}
