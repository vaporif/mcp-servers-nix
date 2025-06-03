{
  lib,
  fetchFromGitHub,
  python3Packages,
  fastmcp,
}:
python3Packages.buildPythonApplication rec {
  pname = "mcp-server-qdrant";
  version = "0.7.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "qdrant";
    repo = "mcp-server-qdrant";
    rev = "v${version}";
    hash = "sha256-O3CPq4ZGbzZQL96u1zKDYPPnWZdey6HcZa7P1CgY6J8=";
  };

  build-system = [ python3Packages.hatchling ];

  dependencies = with python3Packages; [
    mcp
    pydantic
    tzdata
    fastembed
    qdrant-client
  ] ++ [ fastmcp ];

  doCheck = false;

  pythonImportsCheck = [ "mcp_server_qdrant" ];

  meta = {
    description = "Model Context Protocol Server for Qdrant";
    homepage = "https://github.com/qdrant/mcp-server-qdrant";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ natsukium ];
    mainProgram = "mcp-server-qdrant";
  };
}
