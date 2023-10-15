#!/usr/bin/env bash

 
cd olm
cmake . -Bbuild -DCMAKE_TOOLCHAIN_FILE=Windows64.cmake
cmake --build build
cd ..
