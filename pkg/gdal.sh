#!/bin/sh
#
# This file is part of LXE project. See LICENSE file for licensing information.

(
    PKG=gdal
    PKG_VERSION=${GDAL_VER}
    PKG_SUBDIR=${PKG}-${PKG_VERSION}
    PKG_FILE=${PKG}-${PKG_VERSION}.tar.gz
    # PKG_URL="ftp://ftp.remotesensing.org/${PKG}/${PKG_VERSION}/${PKG_FILE}"
    PKG_URL="http://download.osgeo.org/${PKG}/${PKG_VERSION}/${PKG_FILE}"
    PKG_DEPS="gcc zlib expat libpng tiff giflib proj"
    [ "${USE_JPEG_TURBO}" = "true" ] && PKG_DEPS="${PKG_DEPS} libjpeg-turbo" || \
                                        PKG_DEPS="${PKG_DEPS} jpeg"

    CheckPkgVersion
    CheckSourcesAndDependencies

    if IsBuildRequired
    then
        ProcessStandardAutotoolsProjectInBuildDir \
            --with-static-proj4="${SYSROOT}/usr" \
            --with-libjson-c=internal \
            --with-geotiff=internal \
            --with-jpeg \
            --with-libtiff \
            --with-gif \
            --with-expat \
            --without-curl \
            --without-xml2 \
            --without-bsb \
            --without-ogr \
            --without-grib \
            --without-pam \
            --without-gta \
            --without-pg \
            --without-sqlite3 \
            --without-jasper \
            --without-hdf4 \
            --without-hdf5 \
            --without-odbc \
            --without-xerces \
            --without-grass \
            --without-libgrass \
            --without-spatialite \
            --without-cfitsio \
            --without-pcraster \
            --without-pcidsk \
            --without-ogdi \
            --without-fme \
            --without-ecw \
            --without-kakadu \
            --without-mrsid \
            --without-jp2mrsid \
            --without-msg \
            --without-oci \
            --without-mysql \
            --without-ingres \
            --without-dods-root \
            --without-dwgdirect \
            --without-idb \
            --without-sde \
            --without-epsilon \
            --without-perl \
            --without-php \
            --without-ruby \
            --without-python

        cd "${PREFIX}/bin/"
        ln -sf "${SYSROOT}/usr/bin/${PKG}-config" "${TARGET}-${PKG}config"
        ln -sf "${TARGET}-${PKG}-config" "${PKG}-config" 
    fi
)

