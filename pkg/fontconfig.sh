#!/bin/sh
#
# This file is part of LXE project. See LICENSE file for licensing information.

(
    PKG=fontconfig
    PKG_VERSION=${FONTCONFIG_VER}
    PKG_SUBDIR=${PKG}-${PKG_VERSION}
    PKG_FILE=${PKG}-${PKG_VERSION}.tar.gz
    PKG_URL="https://www.freedesktop.org/software/fontconfig/release/${PKG_FILE}"
    PKG_DEPS="gcc pkg-config-settings expat freetype"

    CheckPkgVersion
    CheckSourcesAndDependencies

    if IsBuildRequired
    then
        PrintSystemInfo
        BeginOfPkgBuild
        UnpackSources
        CopySrcAndPrepareBuild

        SetBuildFlags
        SetCrossToolchainPath
        SetCrossToolchainVariables
        ConfigureAutotoolsProjectInBuildDir \
            --with-arch="${TARGET}" \
            --with-sysroot="${SYSROOT}" \
            --with-expat="${SYSROOT}/usr" \
            --disable-libxml2 \
            --disable-docs \
            --with-gnu-ld

        BuildPkg -j ${JOBS}
        InstallPkg install

        CleanPkgBuildDir
        CleanPkgSrcDir
    fi
)

