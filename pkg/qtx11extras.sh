#!/bin/sh

[ -z "${QT5_VER}" ] && exit 1

(
    PKG=qtx11extras
    PKG_DEPS="qtbase"

    . "${PKG_DIR}/qtmodule.sh"
)
