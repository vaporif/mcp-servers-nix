final: prev:
let
  packages = import ../pkgs { pkgs = final; };
in
packages // {
  # Override Python 3.13 packages to disable readabilipy tests
  python313Packages = prev.python313Packages // {
    readabilipy = prev.python313Packages.readabilipy.overrideAttrs (oldAttrs: {
      doCheck = false;
      doInstallCheck = false;
    });
  };
  python313 = prev.python313.override {
    packageOverrides = pfinal: pprev: {
      readabilipy = pprev.readabilipy.overrideAttrs (oldAttrs: {
        doCheck = false;
        doInstallCheck = false;
      });
    };
  };
}
