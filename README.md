# cpp_dev_container_template
Small-ish setup for developing c++ projects in a dev container  

# Features
## Container
Creates a non-root user with the same name as the host user. 

## CMake
Setup for building multiple executables, a library and tests

## vcpkg
Packages added to vcpkg.json will be installed during build

## clang or gcc
Switch between clang and gcc in root CMakeLists.txt (TODO: Figure out how to switch between libc++ and libstdc++ (clang / gcc implementations) too)

## Linting and formatting
Using clang-format and clang-tidy

## Justfile
Used as command-line interface for:  
opening devcontainer `just code` (on host)  
building `just build` (inside the container)  
running `just run` (inside the container)  
testing `just test` (inside the container)  
and more

## Persistent bash history
When the container is started a bash history file is created/mounted to ensure persistent history across rebuild of the container (TODO: Look into how history of multiple terminals works)

## X forwarding
The dev container is configured to allow running UI applications  
Currently requires running "xhost +SI:localuser:`whoami`" (TODO: Use cookie sharing instead)

## Separate build folders for debug and release builds
This allows switching between debug and release builds without having to rebuild the entire project.  
Set up to allow running in release configuration using `just run <app_name>` and debugging (the file currently open) by pressing 'F5' inside vscode 
Release builds: build/release  
Debug builds: build/debug

## Unit testing using GTest
Run all tests using `just test`