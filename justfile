default:
    just --list

####################
# In container
####################

build BUILD_TYPE="release": (configure_cmake BUILD_TYPE)
    cd build/{{BUILD_TYPE}} && \
    make -j

ensure_vcpkg_cache_exists:
    @mkdir -p vcpkg_binary_cache

configure_cmake BUILD_TYPE: ensure_vcpkg_cache_exists
    mkdir -p build && \
    cd build && \
    cmake -B {{BUILD_TYPE}} -DCMAKE_BUILD_TYPE={{BUILD_TYPE}} --preset=default ..
    ln -rfs build/{{BUILD_TYPE}}/compile_commands.json build/compile_commands.json

clean:
    rm -rf build

remove_vcpkg_binary_cache:
    rm -rf vcpkg_binary_cache

run app="template_app" BUILD_TYPE="release": (build BUILD_TYPE)
    cd build/{{BUILD_TYPE}} && \
    app/{{app}}

format_all:
    clang-format -i src/*.cpp src/*.hpp app/*.cpp

lint_all:
    clang-tidy -p build/ src/*.cpp src/*.hpp app/*.cpp

test BUILD_TYPE="release": (build BUILD_TYPE)
    cd build/{{BUILD_TYPE}} && \
    ctest

####################
# On Host
####################

PROJECT_NAME := `basename $PWD`

ensure_persistent_bash_history_exists:
    @mkdir -p ~/.devcontainer;
    @touch ~/.devcontainer/`basename {{justfile_directory()}}`.bash_history;

docker_build:
    docker build \
        --build-arg DOCKER_USERNAME=`whoami` \
        --build-arg DOCKER_USER_ID=`id -u` \
        --build-arg DOCKER_GROUP_ID=`id -g` \
        --build-arg PROJECT_NAME={{PROJECT_NAME}} \
        -t {{PROJECT_NAME}} \
        -f .devcontainer/Dockerfile \
        --target base_dev \
        .

docker_run: docker_build
    docker run -it --rm \
        --device /dev/dri \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        {{PROJECT_NAME}} /bin/bash

code: docker_build ensure_persistent_bash_history_exists
    xhost +SI:localuser:`whoami`
    DOCKER_USERNAME=`whoami` \
    DOCKER_USER_ID=`id -u` \
    DOCKER_GROUP_ID=`id -g` \
    PROJECT_NAME={{PROJECT_NAME}} \
    code --folder-uri "vscode-remote://dev-container+{{`pwd | tr -d '\n' | xxd -p -c 1000000`}}/workspaces/{{PROJECT_NAME}}"
