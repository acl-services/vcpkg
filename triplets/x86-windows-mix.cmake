set(VCPKG_TARGET_ARCHITECTURE x86)
set(VCPKG_PLATFORM_TOOLSET v141)

set(VCPKG_CRT_LINKAGE dynamic)
if(${PORT} MATCHES "zlib|icu|json-spirit")
	set(VCPKG_LIBRARY_LINKAGE dynamic)
else()
	set(VCPKG_LIBRARY_LINKAGE static)
endif()
