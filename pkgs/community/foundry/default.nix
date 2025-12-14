{
  lib,
  stdenv,
  fetchFromGitHub,
  bun,
  makeWrapper,
  nodejs-slim,
}:

let
  version = "0.1.5-unstable-2025-08-02";

  src = fetchFromGitHub {
    owner = "PraneshASP";
    repo = "foundry-mcp-server";
    rev = "a1a8da3cff3331b4d1ed3a25f0ca79b80b2ab7a6";
    hash = "sha256-3nLcAR2Pi0HVX4C/T3//61ZbxspCZyPEtSm7E6VpwkQ=";
  };

  # Step 1: Fixed-output derivation for dependencies
  deps = stdenv.mkDerivation {
    pname = "foundry-mcp-server-deps";
    inherit version src;

    nativeBuildInputs = [ bun ];

    dontBuild = true;
    dontFixup = true;

    installPhase = ''
      export HOME=$TMPDIR

      # Install dependencies (no frozen-lockfile as upstream lockfile is stale)
      bun install --no-cache

      # Copy to output
      mkdir -p $out
      cp -r node_modules $out/
      cp bun.lockb package.json $out/
    '';

    # This hash represents the dependencies
    outputHash = "sha256-qb67KmXsjacDLfwn9PIp3fUIYG/AXCa7Dp2/GFk5Q+Y=";
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
  };

# Step 2: Main build derivation
in
stdenv.mkDerivation {
  pname = "foundry-mcp-server";
  inherit version src;

  nativeBuildInputs = [
    bun
    makeWrapper
  ];

  buildPhase = ''
    runHook preBuild

    export HOME=$TMPDIR

    cp -r ${deps}/node_modules .
    cp ${deps}/bun.lockb .

    substituteInPlace node_modules/.bin/tsc \
      --replace-fail "/usr/bin/env node" "${lib.getExe nodejs-slim}"

    bun run build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/foundry-mcp-server

    cp -r dist $out/lib/foundry-mcp-server/

    cp -r node_modules $out/lib/foundry-mcp-server/
    cp package.json $out/lib/foundry-mcp-server/

    chmod +x $out/lib/foundry-mcp-server/dist/index.js

    mkdir -p $out/bin
    makeWrapper $out/lib/foundry-mcp-server/dist/index.js $out/bin/foundry-mcp-server \
      --prefix PATH : ${lib.makeBinPath [ nodejs-slim ]}

    runHook postInstall
  '';

  passthru = {
    inherit deps;
  };

  meta = {
    description = "EVM-compatible blockchain toolkit for AI Agents powered by Foundry";
    homepage = "https://github.com/PraneshASP/foundry-mcp-server";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "foundry-mcp-server";
  };
}
