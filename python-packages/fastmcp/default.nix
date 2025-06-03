{ lib, python3Packages, fetchPypi }:

python3Packages.buildPythonPackage rec {
  pname = "fastmcp";
  version = "2.6.0";
  format = "wheel";

  src = fetchPypi {
    inherit pname version format;
    hash = "sha256-ZxJNuCt+63YS5KaFjQUaPAO+ucQ3XkpAEXmLzjfIQfg=";
    dist = "py3";
    python = "py3";
  };

  dependencies = with python3Packages; [
    python-dotenv
    exceptiongroup
    httpx
    mcp
    openapi-pydantic
    rich
    typer
    websockets
    authlib
  ];

  pythonImportsCheck = [ "fastmcp" ];

  meta = with lib; {
    description = "Fast Model Context Protocol server implementation";
    homepage = "https://github.com/jlowin/fastmcp";
    license = licenses.asl20;
    maintainers = with maintainers; [ "vaporif" ];
  };
}