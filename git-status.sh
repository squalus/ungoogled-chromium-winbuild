#!/usr/bin/env bash

if [ "$#" != 1 ]; then
    echo "Usage: $0 <git-repo-path>"
    exit 1
fi

cd "$1"
REF=$(git show-ref HEAD -s)
DIRTY=$(git diff-index --quiet HEAD -- || echo -n " *dirty*")
echo "$REF$DIRTY"
