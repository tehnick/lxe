#!/bin/sh
#
# This file is part of LXE project. See LICENSE file for licensing information.

[ -z "${PKG}" ] && exit 1

(
    PKG_SUBDIR=${PKG}-${PKG_VERSION}
    [ ! -z "${PKG_SUBDIR_ORIG}" ] && \
        PKG_FILE=${PKG_SUBDIR_ORIG}.tar.bz2 || \
        PKG_FILE=${PKG_SUBDIR}.tar.bz2
    PKG_URL="https://xorg.freedesktop.org/releases/individual/lib/${PKG_FILE}"

    if ! IsPkgInstalled
    then
        CheckDependencies

        GetSources
        UnpackSources
        PrepareBuild

        SetBuildFlags
        SetCrossToolchainPath
        SetCrossToolchainVariables
        [ "${DEFAULT_LIB_TYPE}" = "static" ] && \
            PrepareLibTypeOpts "both"
        ConfigureAutotoolsProject \
            --enable-malloc0returnsnull

        BuildPkg -j ${JOBS}
        InstallPkg install

        CleanPkgBuildDir
        CleanPkgSrcDir
    fi
)

