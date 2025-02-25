set(ENV{CC} "/usr/bin/gcc")
set(ENV{CXX} "/usr/bin/g++")

set(CMAKE_C_COMPILER "gcc")
set(CMAKE_CXX_COMPILER "g++")
set(CMAKE_CXX_STANDARD_REQUIRED True)


set(CMAKE_CXX_FLAGS
    "-Wall \
     -Wextra \
     -Wpedantic \
     -std=gnu++2c")