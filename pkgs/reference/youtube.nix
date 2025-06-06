{
  lib,
  fetchFromGitHub,
  python3Packages,
}:
python3Packages.buildPythonApplication rec {
  pname = "mcp-youtube";
  version = "0.7.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "jikime";
    repo = "py-mcp-youtube-toolbox";
    rev = "v${version}";
    hash = "d49f78dba0090f6ca84217fb30f0b192d7aaac3d";
  };

  build-system = [ python3Packages.hatchling ];

  dependencies = with python3Packages; [
    google-api-python-client
    mcp
    python-dotenv
    youtube-transcript-api
  ];

  doCheck = false;

  pythonImportsCheck = [ "py_mcp_youtube_toolbox" ];

  meta = {
    description = "YouTube Toolbox";
    homepage = "https://github.com/jikime/py-mcp-youtube-toolbox";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ vaporif ];
    mainProgram = "py-mcp-youtube-toolbox";
  };
}
