# inspired by
# https://github.com/Microsoft/vcpkg/blob/master/ports/imgui/CMakeLists.txt

cmake_minimum_required(VERSION 3.8)

# when updating submodule, change also this version
project(imgui LANGUAGES CXX VERSION 1.7.2)

# turn on PIC to allow static library to link with shared ones 
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_DEBUG_POSTFIX d)
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

set(IMGUI_INCLUDES_PUBLIC
    imgui.h
    imconfig.h
)

add_library(${PROJECT_NAME}
    ${IMGUI_INCLUDES_PUBLIC}
    imgui_internal.h
    imgui.cpp
    imgui_draw.cpp
    imgui_widgets.cpp
)

target_include_directories(${PROJECT_NAME} PUBLIC $<INSTALL_INTERFACE:include>)

install(TARGETS ${PROJECT_NAME}
    EXPORT IMGUIExport
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

install(EXPORT IMGUIExport FILE ${PROJECT_NAME}Config.cmake NAMESPACE ${PROJECT_NAME}:: DESTINATION share/${PROJECT_NAME})

install(FILES ${IMGUI_INCLUDES_PUBLIC} DESTINATION include)

# try to get distribution name (like bionic/xenial etc)
find_program(LSB_RELEASE_EXEC lsb_release)
if (LSB_RELEASE_EXEC) 
  execute_process(COMMAND ${LSB_RELEASE_EXEC} -cs
    OUTPUT_VARIABLE LSB_DISTRIBUTION
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
else()
  message("lsb_release program is not found, distribution name won't be included")
endif()

set(CPACK_PACKAGE_VENDOR "https://github.com/rAum/imgui-pack")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "IMGUI packaged")
set(CPACK_PACKAGE_CONTACT "https://github.com/rAum/imgui-pack")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "https://github.com/rAum/imgui-pack")
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
set(CPACK_SYSTEM_NAME "${LSB_DISTRIBUTION}-${CMAKE_SYSTEM_PROCESSOR}")
set(CPACK_SOURCE_IGNORE_FILES
        /.git
        /.*build.*
        )
include(CPack)
