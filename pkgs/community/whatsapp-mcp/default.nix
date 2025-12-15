{
  lib,
  fetchFromGitHub,
  buildGoModule,
  python3Packages,
}:

let
  version = "0.0.1-unstable-2025-07-13";

  src = fetchFromGitHub {
    owner = "lharries";
    repo = "whatsapp-mcp";
    rev = "7d6a06dcdce1f01dfb24f60e1030d5efba9f3b88";
    hash = "sha256-z05PFRmODaIEfcFwNt7UO4crkgHGeI3fN95AXlYNeeY=";
  };

  # Go bridge that connects to WhatsApp - required for the MCP server to function
  whatsapp-bridge = buildGoModule {
    pname = "whatsapp-bridge";
    inherit version src;

    sourceRoot = "${src.name}/whatsapp-bridge";

    vendorHash = "sha256-8yTDqljzX2N69Q+GHA3BI8FXpR0nhR3N6ke1UFYPp6g=";

    # CGO required for sqlite3
    env.CGO_ENABLED = "1";

    meta = {
      description = "WhatsApp bridge for whatsapp-mcp-server";
      homepage = "https://github.com/lharries/whatsapp-mcp";
      license = lib.licenses.mit;
    };
  };
in
python3Packages.buildPythonApplication {
  pname = "whatsapp-mcp-server";
  inherit version src;
  pyproject = true;

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

  # Include whatsapp-bridge in PATH
  makeWrapperArgs = [
    "--prefix"
    "PATH"
    ":"
    (lib.makeBinPath [ whatsapp-bridge ])
  ];

  pythonImportsCheck = [ "main" ];

  # No tests in the repository
  doCheck = false;

  passthru = { inherit whatsapp-bridge; };

  meta = {
    description = "MCP server for WhatsApp messaging";
    homepage = "https://github.com/lharries/whatsapp-mcp";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "whatsapp-mcp-server";
  };
}
