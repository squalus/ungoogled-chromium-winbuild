#!/usr/bin/env bash
NAME=01-win2016
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR/packer-windows"
"$DIR/packer.sh" \
    build \
    --only=virtualbox-iso \
    -var "output_directory=$DIR/$NAME" \
    -var "vm_name=$NAME" \
    -var "headless=${UGC_HEADLESS:-true}" \
    "$DIR/packer-windows/windows_2016.json"
