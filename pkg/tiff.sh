#!/bin/sh

[ -z "${TIFF_VER}" ] && exit 1

(
    PKG=tiff
    PKG_VERSION=${TIFF_VER}
    PKG_SUBDIR=${PKG}-${PKG_VERSION}
    PKG_FILE=${PKG}-${PKG_VERSION}.tar.gz
    IsPkgVersionGreaterOrEqualTo "3.9.4" && \
        PKG_URL="http://download.osgeo.org/libtiff/${PKG_FILE}" || \
        PKG_URL="http://download.osgeo.org/libtiff/old/${PKG_FILE}"
    PKG_DEPS="gcc"

    if ! IsPkgInstalled
    then
        ProcessStandardAutotoolsProjectInBuildDir
    fi
)

