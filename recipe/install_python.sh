#!/bin/bash
set -ex

cd python

# Build the Python bindings standalone against the XRootD installed by the
# xrootd-build staging output (python/src/CMakeLists.txt supports this via
# find_library(XrdCl) and the installed include/xrootd{,/private} headers).
#
# setup.py appends the CMAKE_ARGS environment variable last on the cmake
# command line, so the hints below take precedence. Pre-seeding
# Python_INCLUDE_DIR keeps FindPython working when cross-compiling (see
# https://conda-forge.org/docs/how-to/advanced/cross-compilation/).
Python_INCLUDE_DIR="$(${PYTHON} -c 'import sysconfig; print(sysconfig.get_path("include"))')"
export CMAKE_ARGS="${CMAKE_ARGS} -DPython_EXECUTABLE=${PYTHON} -DPython_INCLUDE_DIR=${Python_INCLUDE_DIR}"

${PYTHON} -m pip install . -vv --no-deps --no-build-isolation
