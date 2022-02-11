{
  description = "A very basic flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    infra = {
      url = "github:contrun/infra";
    };
  };

  outputs = { self, infra, flake-utils, ... }:
    { nixpkgs = infra.nixpkgs; }
    // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = infra.nixpkgs.${system}; in
      rec {
        packages = flake-utils.lib.flattenTree {
          hello = pkgs.hello;
          gitAndTools = pkgs.gitAndTools;
        };
        defaultPackage = packages.hello;
        apps.hello = flake-utils.lib.mkApp { drv = packages.hello; };
        defaultApp = apps.hello;
      }
    );
}
