#!/bin/sh
#
# This file is part of LXE project. See LICENSE file for licensing information.

(
    PKG=pthreads
    PKG_VERSION=${PTHREADS_VER}
    PKG_SUBDIR=${PKG}-${PKG_VERSION}
    PKG_SUBDIR_ORIG=libpthread-stubs-${PKG_VERSION}
    PKG_FILE=libpthread-stubs-${PKG_VERSION}.tar.bz2
    PKG_URL="https://xcb.freedesktop.org/dist/${PKG_FILE}"
    PKG_DEPS="glibc"

    CheckPkgVersion
    CheckSourcesAndDependencies

    if IsBuildRequired
    then
        PrintSystemInfo
        BeginOfPkgBuild
        UnpackSources
        PrepareBuild

        SetGlibcBuildFlags
        SetCrossToolchainPath
        SetCrossToolchainVariables
        ConfigurePkg \
            --prefix="${SYSROOT}/usr" \
            ${LXE_CONFIGURE_OPTS}

        BuildPkg -j ${JOBS}
        InstallPkg install

        CleanPkgBuildDir
        CleanPkgSrcDir
    fi
)

