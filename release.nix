let
  nixpkgs = import ./packages.nix {};
in
  nixpkgs.haskellPackages.callPackage ./default.nix { imagemagick = nixpkgs.imagemagickBig; }
