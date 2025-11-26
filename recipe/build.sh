#!/bin/bash

set -ex

# Update config.sub and config.guess for modern platforms (especially macOS ARM64)
if [[ -f "${BUILD_PREFIX}/share/libtool/build-aux/config.guess" ]]; then
    cp "${BUILD_PREFIX}/share/libtool/build-aux/config.guess" ./config.guess
    cp "${BUILD_PREFIX}/share/libtool/build-aux/config.sub" ./config.sub
fi

./configure \
    --prefix="${PREFIX}" \
    --bindir="${PREFIX}/bin" \
    --includedir="${PREFIX}/include" \
    --libdir="${PREFIX}/lib" \
    --datarootdir="${PREFIX}/share"

make -j${CPU_COUNT} ${VERBOSE_AT}
make check
make install
