#! /bin/bash

# Reference: https://github.com/MiroPsota/sdkmanagerGUI_docker

sudo mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
sudo update-binfmts --enable qemu-aarch64
sudo update-binfmts --enable qemu-arm
sudo update-binfmts --enable qemu-armeb
