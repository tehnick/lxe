#!/bin/sh
#
# This file is part of LXE project. See LICENSE file for licensing information.

(
    PKG=qtvirtualkeyboard
    PKG_DEPS="qtbase qtdeclarative qtmultimedia qtquickcontrols qtsvg"

    if IsVer1GreaterOrEqualToVer2 "${QT5_VER}" "5.7.0"
    then
        . "${PKG_DIR}/qtmodule.sh"
    else
        . "${PKG_DIR}/qtmodule-nonexistent.sh"
    fi
)

