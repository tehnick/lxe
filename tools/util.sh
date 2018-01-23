#!/bin/bash

PrepareDirs()
{
    mkdir -p "${PREFIX}"
    mkdir -p "${SYSROOT}"
    mkdir -p "${SRC_DIR}"
    mkdir -p "${PKG_SRC_DIR}"
    mkdir -p "${BUILD_DIR}"
    mkdir -p "${LOG_DIR}"
    mkdir -p "${INST_DIR}"

    mkdir -p "${SYSROOT}/lib"
    mkdir -p "${SYSROOT}/usr/lib"

    if [ "${ARCH}" = x86_64 ]
    then
        ln -snf "lib" "${SYSROOT}/lib64"
        ln -snf "lib" "${SYSROOT}/usr/lib64"
    fi
}

SetCrossToolchainPath()
{
    export PATH="${PREFIX}/bin:${ORIG_PATH}"
}

SetSystemPath()
{
    export PATH="${ORIG_PATH}"
}

SetLibraryPath()
{
    export LIBRARY_PATH="${LIBRARY_PATH}:${SYSROOT}/lib"
    export LIBRARY_PATH="${LIBRARY_PATH}:${SYSROOT}/usr/lib"
}

UnsetLibraryPath()
{
    unset LIBRARY_PATH
}

UnsetMakeFlags()
{
    unset MAKEFLAGS
}

SetCrossToolchainVariables()
{
    [ ! -z "${1}" ] && \
        local GCC_SUFFIX=-${1} || \
        local GCC_SUFFIX=-${GCC_VER}

    export CROSS_COMPILE=${TARGET}-
    export cc=${CROSS_COMPILE}gcc${GCC_SUFFIX}
    export CC=${CROSS_COMPILE}gcc${GCC_SUFFIX}
    export cxx=${CROSS_COMPILE}g++${GCC_SUFFIX}
    export CXX=${CROSS_COMPILE}g++${GCC_SUFFIX}
    export AR=${CROSS_COMPILE}ar
    export AS=${CROSS_COMPILE}as
    export LD=${CROSS_COMPILE}ld
    export NM=${CROSS_COMPILE}nm
    export OBJCOPY=${CROSS_COMPILE}objcopy
    export OBJDUMP=${CROSS_COMPILE}objdump
    export RANLIB=${CROSS_COMPILE}ranlib
    export STRIP=${CROSS_COMPILE}strip

    export PKG_CONFIG_SYSROOT_DIR="/"
    export PKG_CONFIG_PATH="${SYSROOT}/usr/lib/pkgconfig"
    export PKG_CONFIG_LIBDIR="${SYSROOT}/usr/lib/pkgconfig"
}

UnsetCrossToolchainVariables()
{
    unset CROSS_COMPILE cc CC cpp CPP cxx CXX
    unset AR AS LD NM OBJCOPY OBJDUMP RANLIB STRIP
    unset PKG_CONFIG_SYSROOT_DIR PKG_CONFIG_PATH PKG_CONFIG_LIBDIR
}

UpdateGCCSymlinks()
{
    [ ! -z "${1}" ] && \
        local GCC_CURRENT_VER=${1} || \
        local GCC_CURRENT_VER=${GCC_VER}

    local FILE=""

    cd "${PREFIX}/bin"
    for N in c++ cpp g++ gcc gcc-ar gcc-nm gcc-ranlib gcov gcov-tool
    do
        FILE="${N}-${GCC_CURRENT_VER}"
        if [ -e "${FILE}" ]
        then
            ln -sf "${FILE}" "${N}"
            ln -sf "${FILE}" "${TARGET}-${N}"
            ln -sf "${FILE}" "${TARGET}-${N}-${GCC_CURRENT_VER}"
        fi
    done

    # Fix for old libGL (mesa) built without RPATH:
    cd "${SYSROOT}/usr/lib"
    for N in libgcc_s.so.1 libstdc++.so.6
    do
        FILE="${SYSROOT}/usr/lib/gcc/${TARGET}/${GCC_CURRENT_VER}/${N}"
        if [ -e "${FILE}" ]
        then
            ln -sf "${FILE}" "${N}"
        fi
    done
}

DeleteGCCSymlinks()
{
    cd "${PREFIX}/bin"
    rm -f c++ cpp g++ gcc gcc-ar gcc-nm gcc-ranlib gcov gcov-tool
}

UpdateCmakeSymlink()
{
    [ ! -z "${1}" ] && \
        local GCC_CURRENT_VER=${1} || \
        local GCC_CURRENT_VER=${GCC_VER}

    ln -sf "${PREFIX}/bin/${TARGET}-gcc-${GCC_CURRENT_VER}-cmake" \
           "${PREFIX}/bin/${TARGET}-cmake"
}

SetBuildFlags()
{
    [ ! -z "${1}" ] && \
        local GCC_CURRENT_VER=${1} || \
        local GCC_CURRENT_VER=${GCC_VER}

    export CFLAGS="-s -Os -fPIC -fdata-sections -ffunction-sections -D_FORTIFY_SOURCE=2"
    IsVer1GreaterOrEqualToVer2 "${GCC_CURRENT_VER}" "4.9.0" && \
        export CFLAGS="${CFLAGS} -fstack-protector-strong"

    export CXXFLAGS="${CFLAGS}"
    if IsVer1GreaterOrEqualToVer2 "${GCC_CURRENT_VER}" "4.9.0"
    then
        IsVer1GreaterOrEqualToVer2 "${GCC_CURRENT_VER}" "6.1.0" && \
            export CXXFLAGS="${CXXFLAGS} -std=c++14" || \
            export CXXFLAGS="${CXXFLAGS} -std=c++11"
    fi

    export LDFLAGS="-Wl,--strip-all -Wl,--as-needed -Wl,-z,relro -Wl,--gc-sections"

    if [ "${GCC_CURRENT_VER}" != "${GCC_VER}" ]
    then
        export CFLAGS="${CFLAGS} -static-libgcc"
        export CXXFLAGS="${CXXFLAGS} -static-libgcc -static-libstdc++"
    fi
}

SetGlibcBuildFlags()
{
    export CFLAGS="-s -O2 -U_FORTIFY_SOURCE"
    IsVer1GreaterOrEqualToVer2 "${GCC_VER}" "4.9.0" && \
        export CFLAGS="${CFLAGS} -fno-stack-protector"

    if [[ "${ARCH}" == i*86 ]]
    then
        export CFLAGS="${CFLAGS} -m32 -march=${ARCH}"
    elif [ "${ARCH}" = x86_64 ]
    then
        export CFLAGS="${CFLAGS} -m64"
    fi

    export CXXFLAGS="${CFLAGS}"
    export LDFLAGS="-Wl,--strip-all"
}

SetGCCBuildFlags()
{
    export CFLAGS="-s -O2 -fPIC -fno-stack-protector -U_FORTIFY_SOURCE"
    export CXXFLAGS="${CFLAGS}"
    export LDFLAGS="-Wl,--strip-all"
}

CheckFail()
{
    if [ ! $? -eq 0 ]
    then
        tail -n 50 "${1}"
        exit 1
    fi
}

CheckDependencies()
{
    if [ ! -z "${PKG_DEPS}" ]
    then
        ( "${MAIN_DIR}/make.sh" ${PKG_DEPS} ) || exit 1
    fi
}

IsVer1GreaterOrEqualToVer2()
{
    [ "${1}" = "$(echo -e "${1}\n${2}" | sort -V | tail -n1)" ] && \
        return 0 || \
        return 1
}

IsPkgVersionGreaterOrEqualTo()
{
    IsVer1GreaterOrEqualToVer2 "${PKG_VERSION}" "${1}" && \
        return 0 || \
        return 1
}

IsPkgInstalled()
{
    [ -e "${INST_DIR}/${PKG}" ] && \
        return 0 || \
        return 1
}

PrintSystemInfo()
{
    echo "[config]   ${CONFIG}"
}

BeginOfPkgBuild()
{
    echo "[build]    ${PKG}"
}

BeginDownload()
{
    echo "[download] ${PKG_FILE}"
}

EndOfPkgBuild()
{
    date -R > "${INST_DIR}/${PKG}"
    echo "[done]     ${PKG}"
}

CheckPkgUrl()
{
    if [ ! -z "${PKG_URL_2}" ]
    then
        if [ $(curl -I "${PKG_URL}" 2>/dev/null | grep '404 Not Found' | wc -l) != "0" ]
        then
            PKG_URL="${PKG_URL_2}"
        elif ! curl -I "${PKG_URL}" &> /dev/null
        then
            PKG_URL="${PKG_URL_2}"
        fi
        unset PKG_URL_2
    fi
}

GetSources()
{
    PrintSystemInfo

    local WGET="wget -v -c --no-config --no-check-certificate --max-redirect=50"
    local LOG_FILE="${LOG_DIR}/${PKG_SUBDIR}/tarball-download.log"
    local TARBALL_SIZE="${LOG_DIR}/${PKG_SUBDIR}/tarball-size.info"
    mkdir -p "${LOG_DIR}/${PKG_SUBDIR}"
    cd "${SRC_DIR}"
    if [ ! -e "${PKG_FILE}" ]
    then
        CheckPkgUrl
        local SIZE=$(curl -I "${PKG_URL}" 2>&1 | sed -ne "s|^Content-Length: \(.*\)$|\1|p")
        echo "${SIZE}" > "${TARBALL_SIZE}"
        BeginDownload
        ${WGET} -o "${LOG_FILE}" -O "${PKG_FILE}" "${PKG_URL}"
        CheckFail "${LOG_FILE}"
    elif [ -e "${TARBALL_SIZE}" ]
    then
        CheckPkgUrl
        local SIZE=$(cat "${TARBALL_SIZE}")
        local FILE_SIZE=$(curl -I "file:${SRC_DIR}/${PKG_FILE}" 2>&1 | sed -ne "s|^Content-Length: \(.*\)$|\1|p")
        if [ "${FILE_SIZE}" != "${SIZE}" ]
        then
            BeginDownload
            ${WGET} -o "${LOG_FILE}" -O "${PKG_FILE}" "${PKG_URL}"
            CheckFail "${LOG_FILE}"
        fi
    fi
    local CHECKSUMS_DATABASE_FILE="${MAIN_DIR}/etc/_checksums.database.txt"
    if [ $(grep "${PKG_FILE}" "${CHECKSUMS_DATABASE_FILE}" | wc -l) != "1" ]
    then
        echo "[checksum] ${PKG_FILE}"
        echo "Error! Checksum for file \"${PKG_FILE}\" is not found in"
        echo "${CHECKSUMS_DATABASE_FILE}"
        exit 1
    fi
    local PKG_CHECKSUM=$(cat "${CHECKSUMS_DATABASE_FILE}" | sed -ne "s|^\(.*\)  ${PKG_FILE}$|\1|p")
    local TARBALL_CHECKSUM=$(openssl dgst -sha256 "${PKG_FILE}" 2>/dev/null | sed -n 's,^.*\([0-9a-f]\{64\}\)$,\1,p')
    if [ "${TARBALL_CHECKSUM}" != "${PKG_CHECKSUM}" ]
    then
        echo "[checksum] ${PKG_FILE}"
        echo "Error! Checksum mismatch:"
        echo "TARBALL_CHECKSUM = ${TARBALL_CHECKSUM}"
        echo "PKG_CHECKSUM     = ${PKG_CHECKSUM}"
        exit 1
    fi

    BeginOfPkgBuild
}

UnpackSources()
{
    set -e
    cd "${PKG_SRC_DIR}"
    [ ! -z "${PKG_SUBDIR_ORIG}" ] && \
            local SUBDIR="${PKG_SUBDIR_ORIG}" || \
            local SUBDIR="${PKG_SUBDIR}"

    if [ ! -d "${SUBDIR}" ]
    then
        cp -a "${SRC_DIR}/${PKG_FILE}" .
        if [[ "${PKG_FILE}" == *.zip ]]
        then
            unzip -q "${PKG_FILE}"
        else
            tar xf "${PKG_FILE}"
        fi
        rm "${PKG_FILE}"
        if [ -e "${MAIN_DIR}/pkg/${PKG}-patches.sh" ]
        then
            . "${MAIN_DIR}/pkg/${PKG}-patches.sh"
        elif [ -h "${MAIN_DIR}/pkg/${PKG}-patches.sh" ]
        then
            . "${MAIN_DIR}/pkg/${PKG}-patches.sh"
        fi
    fi
    set +e
}

PrepareBuild()
{
    mkdir -p "${BUILD_DIR}/${PKG_SUBDIR}"
    cd "${LOG_DIR}/${PKG_SUBDIR}"
    rm -f configure.log make.log make-install.log

    PrepareLibTypeOpts
    UnsetMakeFlags
}

CopySrcAndPrepareBuild()
{
    if [ -z "${PKG_SUBDIR_ORIG}" ]
    then 
        cp -afT "${PKG_SRC_DIR}/${PKG_SUBDIR}" "${BUILD_DIR}/${PKG_SUBDIR}"
    else
        cp -afT "${PKG_SRC_DIR}/${PKG_SUBDIR_ORIG}" "${BUILD_DIR}/${PKG_SUBDIR}"
    fi
    cd "${LOG_DIR}/${PKG_SUBDIR}"
    rm -f configure.log make.log make-install.log

    PrepareLibTypeOpts
    UnsetMakeFlags
}

ConfigurePkg()
{
    local LOG_FILE="${LOG_DIR}/${PKG_SUBDIR}/configure.log"
    cd "${BUILD_DIR}/${PKG_SUBDIR}"
    if [ -z "${PKG_SUBDIR_ORIG}" ]
    then
        "${PKG_SRC_DIR}/${PKG_SUBDIR}/configure" ${@} &>> "${LOG_FILE}"
    else
        "${PKG_SRC_DIR}/${PKG_SUBDIR_ORIG}/configure" ${@} &>> "${LOG_FILE}"
    fi
    CheckFail "${LOG_FILE}"
}

ConfigurePkgInBuildDir()
{
    local LOG_FILE="${LOG_DIR}/${PKG_SUBDIR}/configure.log"
    cd "${BUILD_DIR}/${PKG_SUBDIR}"
    ./configure ${@} &>> "${LOG_FILE}"
    CheckFail "${LOG_FILE}"
}

ConfigureAutotoolsProject()
{
    ConfigurePkg \
        --prefix="${SYSROOT}/usr" \
        ${LXE_CONFIGURE_OPTS} \
        ${LIB_TYPE_OPTS} \
        ${@}
}

ConfigureAutotoolsProjectInBuildDir()
{
    ConfigurePkgInBuildDir \
        --prefix="${SYSROOT}/usr" \
        ${LXE_CONFIGURE_OPTS} \
        ${LIB_TYPE_OPTS} \
        ${@}
}

ConfigureQmakeProject()
{
    local LOG_FILE="${LOG_DIR}/${PKG_SUBDIR}/configure.log"
    local PATH="${PREFIX}/qt5/bin:${PATH}"
    cd "${BUILD_DIR}/${PKG_SUBDIR}"
    "${SYSROOT}/qt5/bin/qmake" ${@} &>> "${LOG_FILE}"
    CheckFail "${LOG_FILE}"
}

ConfigureCmakeProject()
{
    local LOG_FILE="${LOG_DIR}/${PKG_SUBDIR}/configure.log"
    cd "${BUILD_DIR}/${PKG_SUBDIR}"
    if [ -z "${PKG_SUBDIR_ORIG}" ]
    then
        "${PREFIX}/bin/${TARGET}-cmake" "${PKG_SRC_DIR}/${PKG_SUBDIR}" "${@}" &>> "${LOG_FILE}"
    else
        "${PREFIX}/bin/${TARGET}-cmake" "${PKG_SRC_DIR}/${PKG_SUBDIR_ORIG}" "${@}" &>> "${LOG_FILE}"
    fi
    CheckFail "${LOG_FILE}"
}

BuildPkg()
{
    local LOG_FILE="${LOG_DIR}/${PKG_SUBDIR}/make.log"
    cd "${BUILD_DIR}/${PKG_SUBDIR}"
    make ${@} &>> "${LOG_FILE}"
    CheckFail "${LOG_FILE}"
}

InstallPkg()
{
    local LOG_FILE="${LOG_DIR}/${PKG_SUBDIR}/make-install.log"
    cd "${BUILD_DIR}/${PKG_SUBDIR}"
    make ${@} &>> "${LOG_FILE}"
    CheckFail "${LOG_FILE}"

    DeleteExtraFiles
    EndOfPkgBuild
}

ProcessStandardAutotoolsProject()
{
    CheckDependencies

    GetSources
    UnpackSources
    PrepareBuild

    SetBuildFlags
    SetCrossToolchainPath
    SetCrossToolchainVariables
    ConfigureAutotoolsProject ${@}

    BuildPkg -j ${JOBS}
    InstallPkg install

    CleanPkgBuildDir
    CleanPkgSrcDir
}

ProcessStandardAutotoolsProjectInBuildDir()
{
    CheckDependencies

    GetSources
    UnpackSources
    CopySrcAndPrepareBuild

    SetBuildFlags
    SetCrossToolchainPath
    SetCrossToolchainVariables
    ConfigureAutotoolsProjectInBuildDir ${@}

    BuildPkg -j ${JOBS}
    InstallPkg install

    CleanPkgBuildDir
    CleanPkgSrcDir
}

CleanPkgSrcDir()
{
    if [ "${CLEAN_SRC_DIR}" = "true" ]
    then
        [ -z "${PKG_SUBDIR_ORIG}" ] && \
            rm -rf "${PKG_SRC_DIR}/${PKG_SUBDIR}" || \
            rm -rf "${PKG_SRC_DIR}/${PKG_SUBDIR_ORIG}"
    fi
}

CleanPkgBuildDir()
{
    if [ "${CLEAN_BUILD_DIR}" = "true" ]
    then
        rm -rf "${BUILD_DIR}/${PKG_SUBDIR}"
    fi
}

DeleteExtraFiles()
{
    find "${SYSROOT}/lib" "${SYSROOT}/usr/lib" -type f -name '*.la' -exec rm -f {} \;
}

