#!/usr/bin/env bash

set -e
export UGC_HEADLESS="${UGC_HEADLESS:=true}"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
V="$DIR/v.sh"

if [ ! -f "$DIR"/01-win2016/01-win2016.ovf ]; then
    echo "* Creating Windows 2016 base image"
    date
    "$DIR"/packer-win2016.sh
    date
else
    echo "* Skipping Windows 2016 base image"
fi

VFILE="$DIR"/vagrant.rb

echo "* Installing vagrant winrm plugins"
./v.sh plugin install winrm winrm-fs winrm-elevated

echo "* Destroying old machine"
./v.sh -v="$VFILE" destroy -f

BOX_NAME=02-win2016-vs
BOX="$DIR"/$BOX_NAME.box
if [ ! -f "$BOX" ]; then
    echo "* Creating build environment box"
    date
    "$DIR"/packer-install-vs.sh
    date
    N_BOXES=$($V box list | fgrep $BOX_NAME | wc -l)
    if [[ "$N_BOXES" -gt "0" ]]; then
        echo "* Removing old vagrant box"
        "$V" box remove $BOX_NAME
    fi
    echo "* Adding vagrant box"
    "$V" box add "$BOX" --name $BOX_NAME
else
    echo "* Skipping build environment box"
fi

echo "* Creating ungoogled-chromium archive"
"$DIR"/archive-ungoogled-chromium.sh origin/develop

echo "* Running build"
date
./v.sh -v="$VFILE" up
date

echo "* Destroying old machine"
./v.sh -v="$VFILE" halt

echo "* Running post-build"
"$DIR"/post-build.sh
date
