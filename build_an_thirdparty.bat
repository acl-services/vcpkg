@ECHO OFF
set SKIP_VCPKG="OFF"
set CLEANUP="OFF"
:Loop
IF "%~1"=="" GOTO Continue
IF  /I "%~1"=="SKIP_VCPKG" set SKIP_VCPKG="ON"
IF  /I "%~1"=="CLEANUP" set CLEANUP="ON"
SHIFT
GOTO Loop

:Continue
@ECHO ON
IF /I %SKIP_VCPKG% == "OFF" CALL bootstrap-vcpkg.bat

SET packages=minizip[core] boost-format protobuf json-spirit cryptopp icu zlib:x64-windows

SET VCPKG_DEFAULT_TRIPLET=x86-windows-mix

echo Cleanup is %CLEANUP% 
IF %CLEANUP% == "ON" call vcpkg.exe remove --recurse %packages% boost-vcpkg-helpers boost-build boost-modular-build-helper liblzma bzip2 zlib zstd

echo vcpkg.exe install %packages%
vcpkg.exe install %packages%

del /q an-thirdparty.*.nupkg

REM bump version number when add/change setting
SET PACKAGE_ID=14.0.9

vcpkg.exe export --nuget --nuget-id=an-thirdparty --nuget-version="%PACKAGE_ID%" %packages%

IF NOT "%BUILD_NUMBER%" == "" aws s3 cp an-thirdparty.%PACKAGE_ID%.nupkg "s3://acl-rnd-artifacts/an_thirdpartylib/%git_local_branch%/an-thirdparty.%PACKAGE_ID%.nupkg"
