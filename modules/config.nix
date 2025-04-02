{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    format = lib.mkOption {
      type = lib.types.enum [
        "json"
        "yaml"
      ];
      default = "json";
      description = ''
        Configuration file format.
      '';
    };
    flavor = lib.mkOption {
      type = lib.types.enum [
        "claude"
        "vscode"
      ];
      default = "claude";
      description = ''
        Configuration file type.
      '';
    };
    fileName = lib.mkOption {
      type = lib.types.str;
      default = "claude_desktop_config.json";
      description = ''
        Configuration file name.
      '';
    };
    configFile = lib.mkOption {
      type = lib.types.path;
      readOnly = true;
      description = ''
        Generated config file derived from the settings.
      '';
    };
    settings = lib.mkOption {
      default = { };
      type = lib.types.submodule {
        freeformType = (pkgs.formats.json { }).type;
      };
    };
  };

  config =
    let
      keys =
        if (config.flavor == "vscode") then
          [
            "mcp"
            "servers"
          ]
        else
          [ "mcpServers" ];
    in
    {
      configFile =
        let
          serverConfig = config.settings.servers;
          extraConfig = lib.removeAttrs config.settings [ "servers" ];
          format = pkgs.formats.${config.format} { };
        in
        format.generate config.fileName (
          lib.recursiveUpdate (lib.setAttrByPath keys serverConfig) extraConfig
        );
    };
}
