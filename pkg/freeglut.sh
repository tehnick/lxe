#!/bin/sh

[ -z "${FREEGLUT_VER}" ] && exit 1

(
    PKG=freeglut
    PKG_VERSION=${FREEGLUT_VER}
    PKG_SUBDIR=${PKG}-${PKG_VERSION}
    PKG_FILE=${PKG}-${PKG_VERSION}.tar.gz
    PKG_URL="http://sourceforge.net/projects/${PKG}/files/${PKG}/${PKG_VERSION}/${PKG_FILE}"
    PKG_DEPS="gcc mesa libxi"
    [ ! -z "${GLU_VER}" ] && PKG_DEPS="${PKG_DEPS} glu"

    if ! IsPkgInstalled
    then
        CheckDependencies

        GetSources
        UnpackSources
        PrepareBuild

        SetBuildFlags
        SetCrossToolchainPath
        SetCrossToolchainVariables
        if IsPkgVersionGreaterOrEqualTo "3.0.0"
        then
            ConfigureCmakeProject \
                -DCMAKE_BUILD_TYPE=Release \
                -DPKG_CONFIG_EXECUTABLE="${PREFIX}/bin/${TARGET}-pkg-config" \
                -DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
                -DCMAKE_SHARED_LINKER_FLAGS="${LDFLAGS}" \
                -DCMAKE_EXE_LINKER_FLAGS="${LDFLAGS}" \
                -DFREEGLUT_BUILD_SHARED_LIBS=OFF \
                -DFREEGLUT_BUILD_STATIC_LIBS=ON \
                -DFREEGLUT_REPLACE_GLUT=ON \
                -DFREEGLUT_GLES=OFF \
                -DFREEGLUT_BUILD_DEMOS=OFF \
                "${PKG_SRC_DIR}/${PKG_SUBDIR}"

        else
            PrepareLibTypeOpts "static"
            ConfigurePkg \
                --prefix="${SYSROOT}/usr" \
                --with-sysroot="${SYSROOT}" \
                ${LXE_CONFIGURE_OPTS} \
                ${LIB_TYPE_OPTS} \
                --enable-replace-glut \
                --disable-debug \
                --with-gnu-ld
        fi

        BuildPkg -j ${JOBS}
        InstallPkg install

        CleanPkgBuildDir
        CleanPkgSrcDir
    fi
)

