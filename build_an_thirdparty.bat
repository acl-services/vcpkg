CALL bootstrap-vcpkg.bat

SET VCPKG_DEFAULT_TRIPLET=x86-windows-mix

vcpkg.exe install zlib protobuf

IF "%BUILD_NUMBER%"=="" (SET   BUILD_NUMBER="100")

vcpkg.exe export --nuget --nuget-id=an-thirdparty --nuget-version=14.0.%BUILD_NUMBER% zlib protobuf