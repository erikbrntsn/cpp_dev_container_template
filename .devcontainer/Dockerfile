FROM ubuntu:24.10 AS base_dev

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN apt update && apt -y install \
    # clang
    lsb-release wget software-properties-common gnupg \
    # vcpkg
    curl zip unzip tar pkg-config

ARG CLANG_VERSION=20
ARG GCC_VERSION=14
    
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh $CLANG_VERSION all

RUN apt update && apt -y install \
    g++-$GCC_VERSION

RUN apt update && apt install -y \
    sudo git\
    make cmake cmake-curses-gui \
    just

RUN apt install -y apt-file && apt-file update

ARG DOCKER_USERNAME=vscode
ARG DOCKER_USER_ID=1000
ARG DOCKER_GROUP_ID=1000

RUN userdel ubuntu && \
    groupadd -g $DOCKER_GROUP_ID $DOCKER_USERNAME && \
    useradd $DOCKER_USERNAME -u $DOCKER_USER_ID -g $DOCKER_GROUP_ID -m -s /bin/bash && \
    echo "$DOCKER_USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$DOCKER_USERNAME

RUN ln -s /usr/bin/clang-format-$CLANG_VERSION /usr/bin/clang-format && \
    ln -s /usr/bin/clang-tidy-$CLANG_VERSION /usr/bin/clang-tidy && \
    ln -s /usr/bin/clang++-$CLANG_VERSION /usr/bin/clang++ && \
    ln -s /usr/bin/clang-$CLANG_VERSION /usr/bin/clang && \
    ln -s /usr/bin/g++-$GCC_VERSION /usr/bin/g++
    
USER $DOCKER_USERNAME

RUN cd /tmp && \
    git clone https://github.com/microsoft/vcpkg.git && \
    cd vcpkg && \
    ./bootstrap-vcpkg.sh -disableMetrics

ARG PROJECT_NAME=unnamed_project
    
ENV VCPKG_ROOT=/tmp/vcpkg
ENV PATH=$VCPKG_ROOT:$PATH
ENV VCPKG_BINARY_SOURCES="clear;files,/workspaces/$PROJECT_NAME/vcpkg_binary_cache,readwrite"
