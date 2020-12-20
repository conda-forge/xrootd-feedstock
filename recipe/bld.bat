@echo on

mkdir build
if errorlevel 1 exit 1

cmake ^
    -G "Ninja" ^
    -D CMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
    -D CMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -D CMAKE_INSTALL_LIBDIR="lib" ^
    -D CMAKE_BUILD_TYPE=Release ^
    -D PYTHON_EXECUTABLE="%PYTHON%" ^
    -D PYTHON_INCLUDE_DIR="%PREFIX%/include" ^
    -S . -B build
if errorlevel 1 exit 1

cmake --build build --target install
if errorlevel 1 exit 1
