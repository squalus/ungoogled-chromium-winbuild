#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CACHE_DIR="$DIR/cache"
env PACKER_CACHE_DIR="$CACHE_DIR" \
    PACKER_LOG= \
    CHECKPOINT_DISABLE=1 \
    packer "$@"
