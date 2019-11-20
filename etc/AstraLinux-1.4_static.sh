#!/bin/sh

### System info ###
SYSTEM="AstraLinux-1.4_static"
ARCH=x86_64
TARGET=${ARCH}-cross-linux-gnu
DEFAULT_LIB_TYPE=static


### Build tools ###
# GCC_VER=4.7.2
GCC_VER=4.7.4
# GCC_EXTRA_VER=4.9.3
GCC_EXTRA_VER=9.2.0
# BINUTILS_VER=2.22
BINUTILS_VER=2.27

MAKE_VER=3.81
TEXINFO_VER=4.13
LIBTOOL_VER=2.4.2
MAKEDEPEND_VER=1.0.5
GAWK_VER=4.0.1

CMAKE_VER=2.8.12.1
CMAKE_SUBVER=2.8
PKGCONFIG_VER=0.26
CCACHE_VER=3.7.6


### System kernel ###
LINUX_VER=3.16.7
LINUX_SUBVER=3.x


### Basic libraries ###
GLIBC_VER=2.13
PTHREADS_VER=0.3


### Graphic subsystem related libraries ###
LIBPCIACCESS_VER=0.13.1

X11PROTO_CORE_VER=7.0.23
X11PROTO_INPUT_VER=2.3
X11PROTO_KB_VER=1.0.6
X11PROTO_XEXT_VER=7.3.0
X11PROTO_FIXES_VER=5.0
X11PROTO_DAMAGE_VER=1.2.1
X11PROTO_GL_VER=1.4.17
X11PROTO_DRI2_VER=2.8
X11PROTO_XF86BIGFONT_VER=1.2.0
X11PROTO_XF86VIDMODE_VER=2.3.1
X11PROTO_RENDER_VER=0.11.1
X11PROTO_RANDR_VER=1.4.0
X11PROTO_SCRNSAVER_VER=1.2.2

LIBXAU_VER=1.0.7
LIBXDMCP_VER=1.1.1
LIBXCB_VER=1.10
XCB_PROTO_VER=${LIBXCB_VER}

XTRANS_VER=1.3.4
LIBX11_VER=1.6.2
LIBXEXT_VER=1.3.1
LIBXFIXES_VER=5.0
LIBXDAMAGE_VER=1.1.3
LIBXXF86VM_VER=1.1.2
LIBXRENDER_VER=0.9.7
LIBXRANDR_VER=1.4.2
LIBXI_VER=1.7.2
LIBXT_VER=1.1.3
LIBSM_VER=1.2.1
LIBICE_VER=1.0.8
LIBXSS_VER=1.2.2
LIBXKBCOMMON_VER=0.4.1

LIBDRM_VER=2.4.54
MESA_VER=10.1.4
GLU_VER=9.0.0


### System libraries ###
UDEV_VER=175
LIBUSB_VER=1.0.11
PCIUTILS_VER=3.1.9
USBUTILS_VER=005
SYSFSUTILS_VER=2.1.0

LIBXML2_VER=2.9.9
LIBXSLT_VER=1.1.33
EXPAT_VER=2.2.6

ZLIB_VER=1.2.11
BZIP2_VER=1.0.6

LIBPNG_VER=1.2.59
LIBPNG_SUBVER=12
JPEG_VER=9c
JPEG_TURBO_VER=1.5.2
USE_JPEG_TURBO=
TIFF_VER=4.0.10
GIFLIB_VER=5.1.4
YASM_VER=1.3.0

LIBGPG_ERROR_VER=1.36
LIBGCRYPT_VER=1.8.4
OPENSSL_VER=1.0.2t
OPENSSL_SUBVER=1.0.2

LIBUUID_VER=2.33.2
LIBUUID_SUBVER=2.33
#HARFBUZZ_VER=1.7.1
HARFBUZZ_VER=
FREETYPE_VER=2.10.0
FONTCONFIG_VER=2.13.1

SQLITE_VER=3.28.0
SQLITE_FOSSIL_VER=884b4b7e

ASPELL_VER=0.60.6.1
HUNSPELL_VER=1.7.0
LIBIDN_VER=1.35
ATTR_VER=2.4.48
CURL_VER=7.65.0
ICU_VER=4.8.1.1


### Developer libraries ###
PROTOBUF_VER=3.6.1
BOOST_VER=1.67.0
PCRE_VER=8.43
PCRE2_VER=10.33

FREEGLUT_VER=3.0.0
SDL2_VER=2.0.8
LUA_VER=5.3.3

QT4_VER=4.8.7
QT4_SUBVER=4.8
QT5_VER=5.13.2
QT5_SUBVER=5.13

QCA_VER=2.1.3
QWT_VER=6.1.4
QTKEYCHAIN_VER=0.9.1

PROJ_VER=5.1.0
GDAL_VER=2.2.3
OPENSCENEGRAPH_VER=3.6.2
OSGEARTH_VER=2.9

EXIV2_VER=0.25
OPENCV_VER=3.4.0

X264_VER=20180806-2245
FFMPEG_VER=4.1.3


### Extra libraries ###
LIBFCGI_VER=2.4.2
MINIZIP_VER=1.1
MINIUPNPC_VER=2.0

TIDY_HTML5_VER=5.4.0
LIBOTR_VER=4.1.1
MXML_VER=2.11
TINYXML2_VER=6.0.0

LIBSIGNAL_PROTOCOL_C_VER=2.3.2

QTWEBKIT_VER=5.212
QTWEBKIT_GIT_VER=72cfbd7664f21fcc0e62b869a6b01bf73eb5e7da

