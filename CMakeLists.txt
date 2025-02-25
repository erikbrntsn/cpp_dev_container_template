cmake_minimum_required(VERSION 3.25)

set(COMPILER "clang")

if (${COMPILER} STREQUAL "clang")
    include(cmake/clang-toolchain.cmake)
elseif (${COMPILER} STREQUAL "gcc")
    include(cmake/gcc-toolchain.cmake)
endif()

project(template_project
    VERSION "0.0.1"
    DESCRIPTION "A c++ project template"
    LANGUAGES CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# vcpkg
find_package(GTest REQUIRED)

set(LINK_LIBS
    GTest::gmock_main)

set(CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} \
    -O3"
)

set(CMAKE_CXX_FLAGS_DEBUG
    "${CMAKE_CXX_FLAGS_DEBUG} \
    -g \
    -O0 \
    -fsanitize=address \
    -fno-omit-frame-pointer"
)

enable_testing()
include(CTest)

add_subdirectory(app)
add_subdirectory(src)
add_subdirectory(tests)

target_link_libraries(${PROJECT_NAME}_lib PUBLIC
    stdc++exp
    ${LINK_LIBS}
)
