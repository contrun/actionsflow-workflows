let pkgs = import ./getPkgs.nix { };
in with pkgs; [ myPackages.wallabag-saver ]
