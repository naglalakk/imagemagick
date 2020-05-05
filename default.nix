{ mkDerivation, base, bytestring, directory, exceptions, filepath
, hpack, imagemagick, lifted-base, QuickCheck, resourcet, stdenv
, tasty, tasty-hunit, text, transformers, vector
}:
mkDerivation {
  pname = "imagemagick";
  version = "0.0.6.1";
  src = ./.;
  doCheck = false;
  isLibrary = true;
  isExecutable = true;
  buildDepends = [ imagemagick ];
  configureFlags = [
    "--extra-include-dirs=${imagemagick.dev}/include/ImageMagick"
  ];
  libraryHaskellDepends = [
    base bytestring filepath resourcet text transformers vector
  ];
  libraryPkgconfigDepends = [ imagemagick ];
  librarySystemDepends = [ imagemagick ];
  libraryToolDepends = [ hpack ];
  testHaskellDepends = [
    base bytestring directory exceptions filepath lifted-base
    QuickCheck resourcet tasty tasty-hunit text transformers vector
  ];
  prePatch = "hpack";
  description = "bindings to imagemagick library";
  license = stdenv.lib.licenses.mit;
}
