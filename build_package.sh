#!/bin/bash

BOARD=x86_64
BUILD_DIR = ./build/$(BOARD)

mkdir -p $(BUILD_DIR)

cat packages/order.$BOARD | while read line; do
    echo $line
    cd packages/$line
    makepkg -f $line
    if [ $line == "kvmd" ]; then
        sudo pacman -U kvmd-3.308-1-any.pkg.tar.* --noconfirm
        sudo pacman -U kvmd-platform-v0-hdmiusb-rpi3-3.308-1-any.pkg.tar.* --noconfirm
        cp $line*.pkg.tar.* $BUILD_DIR
    else
        sudo pacman -U $line*.pkg.tar.* --noconfirm
        cp $line*.pkg.tar.* $BUILD_DIR
    fi

    cd -
done