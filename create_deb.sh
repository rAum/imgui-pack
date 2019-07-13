#!/bin/bash

set -e

cp CMakeLists.txt imgui/
mkdir -p imgui/build && cd imgui/build
cmake ..
cpack -G "DEB"
cp *.deb ../..

