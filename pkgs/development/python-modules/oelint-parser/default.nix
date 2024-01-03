{ lib
, nix-update-script
, fetchPypi
, buildPythonPackage
, regex
, pip
}:

buildPythonPackage rec {
  pname = "oelint-parser";
  version = "2.13.3";
  format = "setuptools";

  src = fetchPypi {
    inherit version;
    pname = "oelint_parser";
    hash = "sha256-pjonw0VZlDK3xf8cfgn+qT4jZSYD8wRSDLz1Go9Y5so=";
  };

  buildInputs = [ pip ];
  propagatedBuildInputs = [ regex ];
  pythonImportsCheck = [ "oelint_parser" ];

  # Fail to run inside the code the build.
  doCheck = false;

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "Alternative parser for bitbake recipes";
    homepage = "https://github.com/priv-kweihmann/oelint-parser";
    changelog = "https://github.com/priv-kweihmann/oelint-parser/releases/tag/v${version}";
    license = licenses.bsd2;
    maintainers = with maintainers; [ otavio ];
  };
}
