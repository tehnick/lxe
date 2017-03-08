#!/bin/sh

[ -z "${LIBOTR_VER}" ] && exit 1

(
    PKG=libotr
    PKG_VERSION=${LIBOTR_VER}
    PKG_SUBDIR=${PKG}-${PKG_VERSION}
    PKG_FILE=${PKG}-${PKG_VERSION}.tar.gz
    PKG_URL="https://otr.cypherpunks.ca/${PKG_FILE}"
    PKG_DEPS="gcc libgpg-error libgcrypt"

    if ! IsPkgInstalled
    then
        ProcessStandardAutotoolsProjectInBuildDir
    fi
)
