#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .

if [[ "$CONDA_BUILD_CROSS_COMPILATION" == 1 && $target_platform == "osx-arm64" ]]; then
    export ac_cv_va_copy=C99
fi

./configure  --prefix=$PREFIX
make -j
make install
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
make check
fi
