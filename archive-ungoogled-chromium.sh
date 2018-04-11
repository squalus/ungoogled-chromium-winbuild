#!/usr/bin/env bash

set -e
set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

REVISION="$1"

UGC_REPO_DIR="$DIR/ungoogled-chromium"
TEMP_DIR="$DIR/temp"
mkdir -p "$TEMP_DIR"
ARCHIVE_FILE="$TEMP_DIR/ungoogled-chromium-repo.zip"

rm -f "$ARCHIVE_FILE"

cd $UGC_REPO_DIR
UGC_REF=$(git rev-parse HEAD)

git archive --format=zip -o "$ARCHIVE_FILE" --prefix ungoogled-chromium/ $UGC_REF

WINBUILD_GIT_STATUS=$("$DIR"/git-status.sh "$DIR")
UGC_GIT_STATUS=$("$DIR"/git-status.sh "$UGC_DIR")
CHROMIUM_VERSION=$("$DIR"/chromium-version.py)
INFO_TEXT="\
ungoogled-chromium $CHROMIUM_VERSION\r\n\
Eloston/ungoogled-chromium $UGC_GIT_STATUS\r\n\
squalus/ungoogled-chromium-winbuild $WINBUILD_GIT_STATUS\r\n\
build-start $(date -u)"
printf "$INFO_TEXT" > "$TEMP_DIR"/build.txt
