#!/usr/bin/env bash

ROOT_PATH=${PWD}
BUILD_DIR=${ROOT_PATH}/build/x86_64
mkdir -p ${BUILD_DIR}

cat ${ROOT_PATH}/packages/order.x86_64 | while read line; do
    echo $line
    cd ${ROOT_PATH}/packages/$line
    # -s 或 --syncdeps：Install missing dependencies with pacman
    # -f 或 --force：Overwrite existing package
    # -c 或 --clean：Clean up work files after build
    # --noconfirm: Do not ask for confirmation when resolving dependencies
    makepkg -sfc --noconfirm $line
    cp $line*.pkg.tar.* ${BUILD_DIR}
    sudo pacman -U $line*.pkg.tar.* --noconfirm    
    cp $line*.pkg.tar.* ${BUILD_DIR}
    cd -
done