{ lib, python3Packages, fetchPypi }:

{
  fastmcp = python3Packages.buildPythonPackage rec {
    pname = "fastmcp";
    version = "2.6.0";

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-Fcp1q5uVw2g62oLXQDyC6PuudLve1Ed2mQ3RkkVKjDg=";
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
      maintainers = with maintainers; [ "vaporif" ];
    };
  };
}
