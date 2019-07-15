IF NOT "%1" == "SKIP_VCPKG" CALL bootstrap-vcpkg.bat

SET packages=minizip boost-format protobuf json-spirit cryptopp icu zlib:x64-windows

SET VCPKG_DEFAULT_TRIPLET=x86-windows-mix

echo vcpkg.exe install %packages%
vcpkg.exe install %packages%

REM bump version number when add/change setting
SET PACKAGE_ID=14.0.8

vcpkg.exe export --nuget --nuget-id=an-thirdparty --nuget-version="%PACKAGE_ID%" %packages%

IF NOT "%BUILD_NUMBER%" == "" aws s3 cp an-thirdparty.%PACKAGE_ID%.nupkg "s3://acl-rnd-artifacts/an_thirdpartylib/%git_local_branch%/an-thirdparty.%PACKAGE_ID%.nupkg"
