#!/bin/sh

[ -z "${EXIV2_VER}" ] && exit 1

(
    PKG=exiv2
    PKG_VERSION=${EXIV2_VER}
    PKG_SUBDIR=${PKG}-${PKG_VERSION}
    PKG_FILE=${PKG_SUBDIR}.tar.gz
    PKG_URL="http://www.${PKG}.org/${PKG_FILE}"
    PKG_DEPS="gcc zlib expat"

    if ! IsPkgInstalled
    then
        ProcessStandardAutotoolsProjectInBuildDir
    fi
)

