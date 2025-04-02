let
  mkServerModule =
    {
      name,
      packageName ? "mcp-server-${name}",
    }:
    {
      config,
      pkgs,
      lib,
      servers,
      ...
    }:
    let
      cfg = config.programs.${name};
    in
    {
      options.programs.${name} = {
        enable = lib.mkEnableOption name;
        package = lib.mkPackageOption servers packageName { };
        wrapPackageWithEnvFile = lib.mkOption {
          type = lib.types.bool;
          default = (config.flavor != "vscode");
          description = ''
            Whether to wrap the package with an environment file.
            When flavor is set to 'vscode', the environment file is passed directly as a parameter instead of wrapping by default.
          '';
        };
        type = lib.mkOption {
          type = lib.types.nullOr (
            lib.types.enum [
              "sse"
              "stdio"
            ]
          );
          default = null;
          description = ''
            Server connection type.
          '';
        };
        args = lib.mkOption {
          type =
            with lib.types;
            listOf (oneOf [
              bool
              int
              str
            ]);
          default = [ ];
          description = ''
            Array of arguments passed to the command.
          '';
        };
        env = lib.mkOption {
          type =
            with lib.types;
            attrsOf (oneOf [
              bool
              int
              str
            ]);
          default = { };
          description = ''
            Environment variables for the server.
            For security reasons, do not hardcode your credentials in the env.
            All files in /nix/store can be read by anyone with access to the store.
            Always use envFile instead.
          '';
        };
        url = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = ''
            URL of the server (for "sse").
          '';
        };
        envFile = lib.mkOption {
          type = lib.types.nullOr lib.types.path;
          default = null;
          description = ''
            Path to an .env from which to load additional environment variables.
          '';
        };
      };

      config.settings.servers =
        let
          wrapped-package = pkgs.writeScriptBin packageName ''
            #!${pkgs.runtimeShell}
            export $(${pkgs.lib.getExe' pkgs.coreutils "cat"} ${lib.escapeShellArg cfg.envFile} | ${pkgs.lib.getExe pkgs.gnugrep} -v '^#' | ${pkgs.lib.getExe' pkgs.findutils "xargs"} -d '\n')
            ${pkgs.lib.getExe cfg.package} "$@"
          '';
          package =
            if (cfg.wrapPackageWithEnvFile && cfg.envFile != null) then wrapped-package else cfg.package;
        in
        lib.mkIf cfg.enable {
          ${name} = lib.filterAttrs (k: v: v != null) (
            {
              command = lib.mkDefault "${lib.getExe package}";
              inherit (cfg)
                args
                env
                type
                url
                ;
            }
            // lib.optionalAttrs (config.flavor == "vscode") { inherit (cfg) envFile; }
          );
        };
    };
  evalModule =
    nixpkgs: config:
    nixpkgs.lib.evalModules {
      modules = [
        {
          _module.args = {
            pkgs = nixpkgs;
          };
        }
        {
          imports = (
            builtins.map (module: ../modules + "/${module}") (builtins.attrNames (builtins.readDir ../modules))
          );
        }
        config
      ];
      specialArgs = {
        servers = nixpkgs.extend (import ../overlays);
        inherit mkServerModule;
      };
    };
in
{
  inherit evalModule;
  mkConfig = pkgs: config: (evalModule pkgs config).config.configFile;
}
