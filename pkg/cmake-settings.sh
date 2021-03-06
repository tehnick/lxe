#!/bin/sh
#
# This file is part of LXE project. See LICENSE file for licensing information.

(
    PKG=cmake-settings
    PKG_DEPS=

    if IsBuildRequired
    then
        CheckDependencies
        PrepareLibTypeOpts

        mkdir -p "${SYSROOT}/usr/share/cmake"
        for GCC_CURRENT_VER in ${GCC_VER} ${GCC_EXTRA_VER}
        do
            SetBuildFlags "${GCC_CURRENT_VER}"

            CMAKE_TOOLCHAIN_FILE="${SYSROOT}/usr/share/cmake/${SYSTEM}.gcc-${GCC_CURRENT_VER}.conf.cmake"

            mkdir -p "${SYSROOT}/usr/share/cmake"
            cat > "${CMAKE_TOOLCHAIN_FILE}" << EOF
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_PREFIX_PATH "${SYSROOT}")
set(CMAKE_SYSTEM_PREFIX_PATH "${SYSROOT}/qt5")
set(CMAKE_FIND_ROOT_PATH "${SYSROOT}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_C_COMPILER "${PREFIX}/bin/${TARGET}-gcc-${GCC_CURRENT_VER}")
set(CMAKE_CXX_COMPILER "${PREFIX}/bin/${TARGET}-g++-${GCC_CURRENT_VER}")
set(CMAKE_INSTALL_PREFIX "${SYSROOT}/usr" CACHE PATH "Installation Prefix")
set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug|Release|RelWithDebInfo|MinSizeRel")
set(CMAKE_CROSS_COMPILING ON) # Workaround for https://www.cmake.org/Bug/view.php?id=14075
set(PKG_CONFIG_EXECUTABLE ${PREFIX}/bin/${TARGET}-pkg-config)

set(CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES "${SYSROOT}/usr/include")
set(CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES "${SYSROOT}/usr/include")

if(NOT DEFINED CMAKE_C_FLAGS)
    set(CMAKE_C_FLAGS "${CFLAGS}" CACHE STRING "" FORCE)
endif()
if(NOT DEFINED CMAKE_CXX_FLAGS)
    set(CMAKE_CXX_FLAGS "${CFLAGS}" CACHE STRING "" FORCE)
endif()
if(NOT DEFINED CMAKE_SHARED_LINKER_FLAGS)
    set(CMAKE_SHARED_LINKER_FLAGS "${CFLAGS}" CACHE STRING "" FORCE)
endif()
if(NOT DEFINED CMAKE_EXE_LINKER_FLAGS)
    set(CMAKE_EXE_LINKER_FLAGS "${CFLAGS}" CACHE STRING "" FORCE)
endif()

if(NOT DEFINED BUILD_SHARED_LIBS)
    set(BUILD_SHARED_LIBS ${CMAKE_SHARED_BOOL} CACHE BOOL "BUILD_SHARED_LIBS")
endif()
if(NOT DEFINED BUILD_STATIC_LIBS)
    set(BUILD_STATIC_LIBS ${CMAKE_STATIC_BOOL} CACHE BOOL "BUILD_STATIC_LIBS")
endif()
if(NOT DEFINED BUILD_SHARED)
    set(BUILD_SHARED ${CMAKE_SHARED_BOOL} CACHE BOOL "BUILD_SHARED")
endif()
if(NOT DEFINED BUILD_STATIC)
    set(BUILD_STATIC ${CMAKE_STATIC_BOOL} CACHE BOOL "BUILD_STATIC")
endif()
EOF

            mkdir -p "${PREFIX}/bin"
            cat > "${PREFIX}/bin/${TARGET}-gcc-${GCC_CURRENT_VER}-cmake" << EOF
#!/bin/sh

cmake -DCMAKE_TOOLCHAIN_FILE="${CMAKE_TOOLCHAIN_FILE}" "\${@}"
EOF
            chmod uog+x "${PREFIX}/bin"/${TARGET}-*cmake

            unset CMAKE_TOOLCHAIN_FILE
        done

        date -R > "${INST_DIR}/${PKG}"
        echo "[config]   ${CONFIG}"
        echo "[no-build] ${PKG}"
    fi
)

