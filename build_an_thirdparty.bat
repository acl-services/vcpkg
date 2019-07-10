IF NOT "%1" == "SKIP_VCPKG" CALL bootstrap-vcpkg.bat

SET packages=boost-format zlib protobuf json-spirit cryptopp

SET VCPKG_DEFAULT_TRIPLET=x86-windows-mix

echo vcpkg.exe install %packages%
vcpkg.exe install %packages%

REM bump version number when add/change setting
SET PACKAGE_ID="14.0.8"

vcpkg.exe export --nuget --nuget-id=an-thirdparty --nuget-version=%PACKAGE_ID% %packages%
