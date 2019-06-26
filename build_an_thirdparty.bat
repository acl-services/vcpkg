CALL bootstrap-vcpkg.bat

SET packages=zlib protobuf

SET VCPKG_DEFAULT_TRIPLET=x86-windows-mix

echo vcpkg.exe install %packages%
vcpkg.exe install %packages%

IF "%BUILD_NUMBER%"=="" (SET   BUILD_NUMBER=100)
SET PACKAGE_ID="14.0.%BUILD_NUMBER%"

vcpkg.exe export --nuget --nuget-id=an-thirdparty --nuget-version=%PACKAGE_ID% %packages%