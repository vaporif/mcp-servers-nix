{
  lib,
  fetchFromGitHub,
  python3Packages,
}:

python3Packages.buildPythonApplication rec {
  pname = "whatsapp-mcp-server";
  version = "0.0.1-unstable-2025-07-13";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "lharries";
    repo = "whatsapp-mcp";
    rev = "7d6a06dcdce1f01dfb24f60e1030d5efba9f3b88";
    hash = "sha256-z05PFRmODaIEfcFwNt7UO4crkgHGeI3fN95AXlYNeeY=";
  };

  sourceRoot = "${src.name}/whatsapp-mcp-server";

  # Upstream is designed to run via `uv run`, not as an installable package.
  # Its pyproject.toml is incomplete - missing [build-system] and [tool.setuptools].
  # Without these, setuptools fails on multiple top-level modules (main.py, whatsapp.py, audio.py).
  # We also add [project.scripts] to create the CLI entry point.
  postPatch = ''
    cat > pyproject.toml << 'EOF'
    [project]
    name = "whatsapp-mcp-server"
    version = "0.1.0"
    description = "MCP server for WhatsApp messaging"
    requires-python = ">=3.11"
    dependencies = [
        "httpx>=0.28.1",
        "mcp>=1.6.0",
        "requests>=2.32.3",
    ]

    [project.scripts]
    whatsapp-mcp-server = "main:mcp.run"

    [build-system]
    requires = ["setuptools"]
    build-backend = "setuptools.build_meta"

    [tool.setuptools]
    py-modules = ["main", "whatsapp", "audio"]
    EOF
  '';

  build-system = [ python3Packages.setuptools ];

  dependencies = with python3Packages; [
    httpx
    mcp
    requests
  ];

  pythonImportsCheck = [ "main" ];

  # No tests in the repository
  doCheck = false;

  meta = {
    description = "MCP server for WhatsApp messaging";
    homepage = "https://github.com/lharries/whatsapp-mcp";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "whatsapp-mcp-server";
  };
}
