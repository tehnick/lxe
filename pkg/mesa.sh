#!/bin/sh
#
# This file is part of LXE project. See LICENSE file for licensing information.

(
    PKG=mesa
    PKG_VERSION=${MESA_VER}
    PKG_SUBDIR=${PKG}-${PKG_VERSION}
    if IsPkgVersionGreaterOrEqualTo "17.0.0"
    then
        PKG_FILE=${PKG}-${PKG_VERSION}.tar.xz
        PKG_URL="ftp://freedesktop.org/pub/${PKG}/${PKG_VERSION}/${PKG_FILE}"
    else
        if IsPkgVersionGreaterOrEqualTo "10.5.0"
        then
            PKG_FILE=${PKG}-${PKG_VERSION}.tar.xz
        else
            PKG_SUBDIR_ORIG=Mesa-${PKG_VERSION}
            PKG_FILE=MesaLib-${PKG_VERSION}.tar.bz2
        fi
        IsPkgVersionGreaterOrEqualTo "10.0" && \
            PKG_URL="ftp://freedesktop.org/pub/mesa/older-versions/${PKG_VERSION:0:2}.x/${PKG_VERSION}/${PKG_FILE}" || \
            PKG_URL="ftp://freedesktop.org/pub/mesa/older-versions/${PKG_VERSION:0:1}.x/${PKG_VERSION}/${PKG_FILE}"
    fi
    PKG_DEPS="gcc pkg-config-settings expat makedepend x11proto-gl x11proto-dri2
              libx11 libxext libxfixes libxdamage libxxf86vm libxt libdrm"
    IsPkgVersionGreaterOrEqualTo "10.5.0" && PKG_DEPS="${PKG_DEPS} udev"
    # libx11-xcb-dev, libxcb-dri2-0-dev, libxcb-xfixes0-dev
    # python, python-libxml2 (for some versions of mesa)

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
        PrepareLibTypeOpts "shared"
        cd "${BUILD_DIR}/${PKG_SUBDIR}"
        autoreconf -vfi &>> "${LOG_DIR}/${PKG_SUBDIR}/autoreconf.log"
        IsPkgVersionGreaterOrEqualTo "10.5.0" && \
            EXTRA_CONFIGURE_OPTS="--enable-sysfs" || \
            EXTRA_CONFIGURE_OPTS=""
        ConfigureAutotoolsProjectInBuildDir \
            "${EXTRA_CONFIGURE_OPTS}" \
            --enable-glx-tls \
            --enable-xcb \
            --disable-egl \
            --disable-glut \
            --disable-glw \
            --disable-dri3 \
            --with-driver=xlib \
            --with-state-trackers=glx \
            --without-gallium-drivers
#             --enable-gles1 \
#             --enable-gles2 \
#             --with-gnu-ld \

        BuildPkg -j ${JOBS}
        InstallPkg install

        CleanPkgBuildDir
        CleanPkgSrcDir
    fi
)

