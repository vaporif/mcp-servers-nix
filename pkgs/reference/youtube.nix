{
  lib,
  fetchFromGitHub,
  python3,
  makeWrapper,
  stdenv
}:
let
  pythonEnv = python3.withPackages (ps: with ps; [
    google-api-python-client
    mcp
    python-dotenv
    youtube-transcript-api
  ]);
in
stdenv.mkDerivation {
  pname = "mcp-youtube";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "jikime";
    repo = "py-mcp-youtube-toolbox";
    rev = "d49f78dba0090f6ca84217fb30f0b192d7aaac3d";
    hash = "sha256-gGbjI+wqCczW2gBiQmPpWGDI1rjUIT87fWdkZ70sQ5E=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin $out/share/py-mcp-youtube-toolbox

    # Copy all Python files
    cp -r *.py $out/share/py-mcp-youtube-toolbox/
    cp -r pyproject.toml requirements.txt $out/share/py-mcp-youtube-toolbox/

    # Create wrapper script
    makeWrapper ${pythonEnv}/bin/python $out/bin/mcp-youtube-server \
      --add-flags "$out/share/py-mcp-youtube-toolbox/server.py" \
      --prefix PYTHONPATH : "$out/share/py-mcp-youtube-toolbox"

  '';

  doCheck = false;

  meta = {
    description = "YouTube Toolbox";
    homepage = "https://github.com/jikime/py-mcp-youtube-toolbox";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ vaporif ];
    mainProgram = "py-mcp-youtube-toolbox";
  };
}
