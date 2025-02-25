set(CMAKE_C_COMPILER "clang")
set(CMAKE_CXX_COMPILER "clang++")
set(CMAKE_CXX_STANDARD 26)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(CMAKE_CXX_FLAGS
    "-Weverything \
     -Wno-c++98-compat-pedantic \
     -Wno-c++20-compat \
     -Wno-global-constructors"
)

set(CMAKE_CXX_FLAGS_DEBUG
     "${CMAKE_CXX_FLAGS_DEBUG} \
     -fsanitize=address"
)