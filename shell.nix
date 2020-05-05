{ nixpkgs ? import ./packages.nix {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, bytestring, directory, exceptions
      , filepath, hpack, imagemagick, lifted-base, QuickCheck, resourcet
      , stdenv, tasty, tasty-hunit, text, transformers, vector
      }:
      mkDerivation {
        pname = "imagemagick";
        version = "0.0.6.1";
        src = ./.;
        isLibrary = true;
        isExecutable = true;
        libraryHaskellDepends = [
          base bytestring filepath resourcet text transformers vector
        ];
        libraryPkgconfigDepends = [ pkgs.imagemagickBig ];
        libraryToolDepends = [ hpack ];
        testHaskellDepends = [
          base bytestring directory exceptions filepath lifted-base
          QuickCheck resourcet tasty tasty-hunit text transformers vector
        ];
        prePatch = "hpack";
        description = "bindings to imagemagick library";
        license = stdenv.lib.licenses.mit;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
