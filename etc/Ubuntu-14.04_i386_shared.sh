#!/bin/sh

### System info ###
SYSTEM="Ubuntu-14.04_i386_shared"
ARCH=i586
TARGET=${ARCH}-cross-linux-gnu
DEFAULT_LIB_TYPE=shared


### Build tools ###
GCC_VER=4.8.2
# GCC_VER=4.8.5
# GCC_EXTRA_VER=4.9.3
GCC_EXTRA_VER=8.2.0
# BINUTILS_VER=2.24
BINUTILS_VER=2.27

# MAKE_VER=3.81
MAKE_VER=3.82
TEXINFO_VER=5.2
LIBTOOL_VER=2.4.2
MAKEDEPEND_VER=1.0.5

CMAKE_VER=2.8.12
CMAKE_SUBVER=2.8
PKGCONFIG_VER=0.26


### System kernel ###
LINUX_VER=3.13.11
LINUX_SUBVER=3.x


### Basic libraries ###
GLIBC_VER=2.19
PTHREADS_VER=0.3


### Graphic subsystem related libraries ###
LIBPCIACCESS_VER=0.13.2

X11PROTO_CORE_VER=7.0.26
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

LIBXAU_VER=1.0.8
LIBXDMCP_VER=1.1.1
LIBXCB_VER=1.10
XCB_PROTO_VER=${LIBXCB_VER}

XTRANS_VER=1.3.4
LIBX11_VER=1.6.2
LIBXEXT_VER=1.3.2
LIBXFIXES_VER=5.0.1
LIBXDAMAGE_VER=1.1.4
LIBXXF86VM_VER=1.1.3
LIBXRENDER_VER=0.9.8
LIBXRANDR_VER=1.4.2
LIBXI_VER=1.7.1
LIBXT_VER=1.1.4
LIBSM_VER=1.2.1
LIBICE_VER=1.0.8
LIBXSS_VER=1.2.2

LIBDRM_VER=2.4.56
MESA_VER=10.1.1
GLU_VER=9.0.0


### System libraries ###
#UDEV_VER=204
UDEV_VER=
LIBUSB_VER=1.0.17
PCIUTILS_VER=3.2.1
USBUTILS_VER=007
SYSFSUTILS_VER=2.1.0

LIBXML2_VER=2.9.1
LIBXSLT_VER=1.1.28
EXPAT_VER=2.1.0

ZLIB_VER=1.2.11
BZIP2_VER=1.0.6

LIBPNG_VER=1.2.50
LIBPNG_SUBVER=12
JPEG_VER=8c
JPEG_TURBO_VER=1.3.0
USE_JPEG_TURBO=
TIFF_VER=4.0.3
GIFLIB_VER=4.1.6
YASM_VER=1.3.0

LIBGPG_ERROR_VER=1.12
LIBGCRYPT_VER=1.5.3
# OPENSSL_VER=1.0.1f
OPENSSL_VER=1.0.1u
OPENSSL_SUBVER=1.0.1

# HARFBUZZ_VER=0.9.27
HARFBUZZ_VER=
# FREETYPE_VER=2.5.2
FREETYPE_VER=2.5.0
FONTCONFIG_VER=2.11.0

SQLITE_VER=3.8.2
SQLITE_FOSSIL_VER=27392118

ASPELL_VER=0.60.6.1
HUNSPELL_VER=1.3.2
LIBIDN_VER=1.28
ATTR_VER=2.4.47
CURL_VER=7.35.0
ICU_VER=52.1


### Developer libraries ###
PROTOBUF_VER=3.6.1
BOOST_VER=1.65.0
PCRE2_VER=10.30

FREEGLUT_VER=3.0.0
SDL2_VER=2.0.8
LUA_VER=5.3.3

QT4_VER=4.8.7
QT4_SUBVER=4.8
QT5_VER=5.11.2
QT5_SUBVER=5.11

QCA_VER=2.1.3
QWT_VER=6.1.3
QTKEYCHAIN_VER=0.9.1

PROJ_VER=5.1.0
GDAL_VER=2.2.3
OPENSCENEGRAPH_VER=3.6.2
OSGEARTH_VER=2.9

EXIV2_VER=0.25
OPENCV_VER=3.4.0

X264_VER=20180806-2245
FFMPEG_VER=4.0.2


### Extra libraries ###
LIBFCGI_VER=2.4.0
MINIZIP_VER=1.1
MINIUPNPC_VER=2.0

TIDY_HTML5_VER=5.4.0
LIBOTR_VER=4.1.1
MXML_VER=2.11
TINYXML2_VER=6.0.0

LIBSIGNAL_PROTOCOL_C_VER=2.3.2

QTWEBKIT_VER=bd0657f9
QTWEBKIT_GIT_VER=bd0657f98aff85b9f06d85a8cf4da6a27f61a56e

