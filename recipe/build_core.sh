#!/bin/bash
set -ex

mkdir build-dir
cd build-dir

if [ "$(uname)" == "Linux" ]; then
    extra_cmake_args="-DCMAKE_AR=${GCC_AR}"
else
    extra_cmake_args=""
fi

# The Python bindings are built separately in install_python.sh against the
# installed libraries, so disable them here. This also keeps
# find_package(Python) out of the cross-compiled main build (CMake >= 4.1,
# policy CMP0190).
cmake ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=release \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_LIBDIR="${PREFIX}/lib" \
    -DCMAKE_PREFIX_PATH="${PREFIX}" \
    -DCMAKE_INSTALL_RPATH="${PREFIX}/lib" \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
    -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
    -DCMAKE_CXX_COMPILER="${GXX}" \
    -DCMAKE_C_COMPILER="${GCC}" \
    -DENABLE_PYTHON=OFF \
    ${extra_cmake_args} \
    ..

make -j${CPU_COUNT}

make install
