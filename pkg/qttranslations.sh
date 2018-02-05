#!/bin/sh
#
# This file is part of LXE project. See LICENSE file for licensing information.

[ -z "${QT5_VER}" ] && exit 1

(
    PKG=qttranslations
    PKG_DEPS="qtbase qttools"

    . "${PKG_DIR}/qtmodule.sh"
)

