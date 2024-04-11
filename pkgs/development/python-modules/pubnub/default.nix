{ lib
, aiohttp
, buildPythonPackage
, busypie
, cbor2
, fetchFromGitHub
, pycryptodomex
, pytestCheckHook
, pytest-vcr
, pytest-asyncio
, requests
, pythonOlder
, setuptools
}:

buildPythonPackage rec {
  pname = "pubnub";
  version = "7.4.4";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = pname;
    repo = "python";
    rev = "refs/tags/v${version}";
    hash = "sha256-4Paodw3t2RvAKrDMcWHIGLs5JNtH/9sP+BTyAm/hj4E=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    aiohttp
    cbor2
    pycryptodomex
    requests
  ];

  nativeCheckInputs = [
    busypie
    pytest-asyncio
    pytest-vcr
    pytestCheckHook
  ];

  disabledTestPaths = [
    # Tests require network access
    "tests/integrational"
    "tests/manual"
    "tests/functional/push"
  ];

  disabledTests = [
    "test_subscribe"
    "test_handshaking"
  ];

  pythonImportsCheck = [
    "pubnub"
  ];

  meta = with lib; {
    description = "Python-based APIs for PubNub";
    homepage = "https://github.com/pubnub/python";
    changelog = "https://github.com/pubnub/python/releases/tag/v${version}";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
