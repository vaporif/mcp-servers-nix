{
  lib,
  stdenv,
  fetchFromGitHub,
  bun,
  makeWrapper,
}:

# TODO: would be great to remove this once nixpkgs
# has native build bun packages derivation
let
  version = "1.0.12";

  src = fetchFromGitHub {
    # TODO: wait until merge https://github.com/upstash/context7/pull/248
    owner = "vaporif";
    repo = "context7";
    rev = "fcd166d95f3619378df8c35c5619ac6e420535a8";
    hash = "sha256-rDDWjhFS6X0WN8UPbP93bGnPo2YPOjndbFiKMI+zHJ0=";
  };

  # Step 1: Fixed-output derivation for dependencies
  deps = stdenv.mkDerivation {
    pname = "context7-mcp-deps";
    inherit version src;

    nativeBuildInputs = [ bun ];

    dontBuild = true;
    dontFixup = true;

    installPhase = ''
      export HOME=$TMPDIR

      # Install dependencies
      bun install --frozen-lockfile --no-cache

      # Copy to output
      mkdir -p $out
      cp -r node_modules $out/
      cp bun.lock package.json $out/
    '';

    # This hash represents the dependencies
    outputHash = "sha256-y9R0MXNH5DO2sxv+eibwrueNZC8jCAVCrMfjJ6FI50E=";
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
  };

  # Step 2: Main build derivation
in stdenv.mkDerivation rec {
  pname = "mcp-context7";
  inherit version src;

  nativeBuildInputs = [ bun makeWrapper ];

  buildPhase = ''
    runHook preBuild

    export HOME=$TMPDIR

    cp -r ${deps}/node_modules .
    cp ${deps}/bun.lock .

    bun run build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/context7-mcp

    cp -r dist $out/lib/context7-mcp/

    cp -r node_modules $out/lib/context7-mcp/
    cp package.json $out/lib/context7-mcp/

    sed -i '1s|^|#!/usr/bin/env bun\n|' $out/lib/context7-mcp/dist/index.js
    chmod +x $out/lib/context7-mcp/dist/index.js

    mkdir -p $out/bin
    makeWrapper $out/lib/context7-mcp/dist/index.js $out/bin/context7-mcp \
      --prefix PATH : ${lib.makeBinPath [ bun ]} \
      --set NODE_ENV production

    runHook postInstall
  '';

  passthru = {
    inherit deps;
  };

  meta = {
    description = "Context7 MCP Server - Up-to-date code documentation for LLMs and AI code editors";
    homepage = "https://context7.com";
    license = lib.licenses.mit;
    maintainers =  [ "vaporif" ];
    mainProgram = "context7-mcp";
  };
}
