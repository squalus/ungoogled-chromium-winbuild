#!/usr/bin/env bash
NAME=02-win2016-vs
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
"$DIR/packer.sh" \
    build \
    -var "output_directory=$DIR/$NAME" \
    -var "box_output=$DIR/$NAME.box" \
    -var "vm_name=$NAME" \
    -var "source_path=$DIR/01-win2016/01-win2016.ovf" \
    -var "headless=${UGC_HEADLESS:-true}" \
    "$DIR/install-vs.json"

