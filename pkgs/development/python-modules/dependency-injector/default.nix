{ lib
, aiohttp
, buildPythonPackage
, fastapi
, fetchFromGitHub
, flask
, httpx
, mypy-boto3-s3
, numpy
, scipy
, pydantic
, pytestCheckHook
, pyyaml
, six
}:

buildPythonPackage rec {
  pname = "dependency-injector";
  version = "4.34.0";

  src = fetchFromGitHub {
    owner = "ets-labs";
    repo = "python-dependency-injector";
    rev = version;
    sha256 = "sha256-MI0+saRe4Zi77otVPGYxrX9z8Jc5K1A1sCxHBS0uta0=";
  };

  propagatedBuildInputs = [
    six
  ];

  checkInputs = [
    aiohttp
    fastapi
    flask
    httpx
    mypy-boto3-s3
    numpy
    pydantic
    scipy
    pytestCheckHook
    pyyaml
  ];

  postPatch = ''
    substituteInPlace requirements.txt \
      --replace "six>=1.7.0,<=1.15.0" "six"
  '';

  disabledTestPaths = [
    # There is no unique identifier to disable the one failing test
    "tests/unit/ext/test_aiohttp_py35.py"
  ];

  pythonImportsCheck = [ "dependency_injector" ];

  meta = with lib; {
    description = "Dependency injection microframework for Python";
    homepage = "https://github.com/ets-labs/python-dependency-injector";
    license = licenses.bsd3;
    maintainers = with maintainers; [ gerschtli ];
  };
}
