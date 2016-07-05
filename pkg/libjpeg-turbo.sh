#!/bin/sh

[ -z "${JPEG_TURBO_VER}" ] && exit 1

(
    PKG=libjpeg-turbo
    PKG_VERSION=${JPEG_TURBO_VER}
    PKG_SUBDIR=${PKG}-${PKG_VERSION}
    PKG_FILE=${PKG_SUBDIR}.tar.gz
    PKG_URL="http://downloads.sourceforge.net/project/${PKG}/${PKG_VERSION}/${PKG_FILE}"
    PKG_DEPS="gcc yasm"

    if ! IsPkgInstalled
    then
        ProcessStandardAutotoolsProject
    fi
)

