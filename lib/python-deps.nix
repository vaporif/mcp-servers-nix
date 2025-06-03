{ lib, python3Packages, fetchPypi }:

{
  fastmcp = python3Packages.buildPythonPackage rec {
    pname = "fastmcp";
    version = "2.6.0";

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-fnDz95Ttof9Br9Mz0YTtU96Afm7UsBsup//9C9tCiwo=";
    };

    build-system = with python3Packages; [
      hatchling
    ];

    dependencies = with python3Packages; [
      pydantic
      httpx
      jinja2
      sse-starlette
    ];

    pythonImportsCheck = [ "fastmcp" ];

    meta = with lib; {
      description = "Fast Model Context Protocol server implementation";
      homepage = "https://github.com/jlowin/fastmcp";
      license = licenses.mit;
      maintainers = with maintainers; [ ];
    };
  };
}