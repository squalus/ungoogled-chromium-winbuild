#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

VAGRANTFILE="$1"
PREFIX=-v
if [[ $1 = $PREFIX* ]]; then
    VAGRANTFILE="${1#$PREFIX=}"
    echo "VAGRANTFILE=$VAGRANTFILE"
    shift
fi
#if [[ "${VAGRANTFILE}" == "" ]]; then
  #printf "Usage: "${0}" <vagrantfile> <vagrant args>\n"
  #exit 1
#fi
#shift
env VAGRANT_CHECKPOINT_DISABLE=1 \
    VAGRANT_HOME="$DIR/vagrant-home" \
    VAGRANT_DOTFILE_PATH="$DIR/vagrant-dotfile" \
    VAGRANT_BOX_UPDATE_CHECK_DISABLE=1 \
    VAGRANT_VAGRANTFILE="$VAGRANTFILE" \
    VAGRANT_DISABLE_VBOXSYMLINKCREATE=1 \
    vagrant "$@"

