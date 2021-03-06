#!/bin/sh
#
# This file is part of LXE project. See LICENSE file for licensing information.

(
    PKG=pciutils
    PKG_VERSION=${PCIUTILS_VER}
    PKG_SUBDIR=${PKG}-${PKG_VERSION}
    PKG_FILE=${PKG}-${PKG_VERSION}.tar.xz
    PKG_URL="https://www.kernel.org/pub/software/utils/pciutils/${PKG_FILE}"
    PKG_DEPS="gcc"

    CheckPkgVersion
    CheckSourcesAndDependencies

    if IsBuildRequired
    then
        PrintSystemInfo
        BeginOfPkgBuild
        UnpackSources

        mkdir -p "${LOG_DIR}/${PKG_SUBDIR}"
        mkdir -p "${SYSROOT}/usr/share/misc"
        cp -av  "${PKG_SRC_DIR}/${PKG_SUBDIR}/pci.ids" \
                "${SYSROOT}/usr/share/misc/pci.ids" > \
                "${LOG_DIR}/${PKG_SUBDIR}/install.log"
        CheckFail "${LOG_DIR}/${PKG_SUBDIR}/install.log"

        date -R > "${INST_DIR}/${PKG}"
        CleanPkgSrcDir
    fi
)

