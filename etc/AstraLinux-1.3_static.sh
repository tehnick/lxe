#!/bin/sh

SYSTEM="AstraLinux-1.3_static"

ARCH=x86_64
TARGET=${ARCH}-cross-linux-gnu
DEFAULT_LIB_TYPE=static

# GCC_VER=4.7.1
GCC_VER=4.7.4
# GCC_EXTRA_VER=4.9.3
GCC_EXTRA_VER=5.4.0
# BINUTILS_VER=2.22
BINUTILS_VER=2.26

LINUX_VER=3.2.27
LINUX_SUBVER=3.x

GLIBC_VER=2.13
PTHREADS_VER=0.3

MAKE_VER=3.81
TEXINFO_VER=4.13
LIBTOOL_VER=2.4.2
MAKEDEPEND_VER=1.0.5

ZLIB_VER=1.2.8
EXPAT_VER=2.1.0
BZIP2_VER=1.0.6
LIBPNG_VER=1.2.56
JPEG_VER=8d
JPEG_TURBO_VER=1.4.1
TIFF_VER=4.0.3
GIFLIB_VER=5.0.5
YASM_VER=1.3.0

OPENSSL_VER=1.0.2d
OPENSSL_SUBVER=${OPENSSL_VER}
LIBGPG_ERROR_VER=1.19
LIBGCRYPT_VER=1.6.3

HARFBUZZ_VER=
FREETYPE_VER=2.5.5
FONTCONFIG_VER=2.11.0

LIBPCIACCESS_VER=0.13.1

X11PROTO_CORE_VER=7.0.23
X11PROTO_INPUT_VER=2.2
X11PROTO_KB_VER=1.0.6
X11PROTO_XEXT_VER=7.2.1
X11PROTO_FIXES_VER=5.0
X11PROTO_DAMAGE_VER=1.2.1
X11PROTO_GL_VER=1.4.15
X11PROTO_DRI2_VER=2.6
X11PROTO_XF86BIGFONT_VER=1.2.0
X11PROTO_XF86VIDMODE_VER=2.3.1
X11PROTO_RENDER_VER=0.11.1
X11PROTO_RANDR_VER=1.3.2

LIBXML2_VER=2.9.2
LIBXSLT_VER=1.1.28
LIBXAU_VER=1.0.7
LIBXDMCP_VER=1.1.1
LIBXCB_VER=1.8.1
XCB_PROTO_VER=1.7.1

XTRANS_VER=1.2.7
LIBX11_VER=1.5.0
LIBXEXT_VER=1.3.1
LIBXFIXES_VER=5.0
LIBXDAMAGE_VER=1.1.3
LIBXXF86VM_VER=1.1.2
LIBXRENDER_VER=0.9.7
LIBXRANDR_VER=1.3.2
LIBXI_VER=1.6.1
LIBXT_VER=1.1.3
LIBSM_VER=1.2.1
LIBICE_VER=1.0.8

LIBDRM_VER=2.4.33
MESA_VER=8.0.3
GLU_VER=

FREEGLUT_VER=3.0.0

QT4_VER=4.8.7
QT4_SUBVER=4.8
QT5_VER=5.7.0
QT5_SUBVER=5.7

SDL2_VER=2.0.4

CMAKE_VER=2.8.8
CMAKE_SUBVER=2.8
PKGCONFIG_VER=0.26

PROJ_VER=4.9.2
GDAL_VER=1.11.1
OPENSCENEGRAPH_VER=3.4.0

VLC_VER=2.0.3

LIBFCGI_VER=2.4.0

PROTOBUF_VER=2.6.1

