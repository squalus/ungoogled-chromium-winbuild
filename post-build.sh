#!/usr/bin/env bash

STRIP_NONDETERM=$(which strip-nondeterminism)
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PRODUCTS_DIR="$DIR"/products
rm -rf "$PRODUCTS_DIR"
mkdir -p "$PRODUCTS_DIR"
TEMP_DIR="$DIR"/shared
PRODUCT_NAME=$(basename "$TEMP_DIR"/ungoogled-chromium_*.zip)
echo "* Product: $PRODUCT_NAME"
mv "$TEMP_DIR"/"$PRODUCT_NAME" "$PRODUCTS_DIR"
mv "$TEMP_DIR"/build.txt "$PRODUCTS_DIR"
rm -rf "$TEMP_DIR"/*
cd "$PRODUCTS_DIR"
PRODUCT_FILE="$PRODUCTS_DIR/$PRODUCT_NAME"

if [ -x "$STRIP_NONDETERM" ]; then
    echo "* Running strip-nondeterminism"
    "$STRIP_NONDETERM" "$PRODUCT_FILE"
else
    echo "* Skipping strip-nondeterminism, binary not found"
fi

echo "* Hashing"

MD5=$(md5sum "$PRODUCT_FILE" | cut -d ' ' -f 1)
SHA1=$(sha1sum "$PRODUCT_FILE" | cut -d ' ' -f 1)
SHA256=$(sha256sum "$PRODUCT_FILE" | cut -d ' ' -f 1)
CHROMIUM_VERSION=$($DIR/chromium-version.py)
PUB_TIME=$(python3 -c "import datetime; print(datetime.datetime.utcnow().isoformat())")
UGC_COMMIT=$($DIR/git-status.sh "$DIR/ungoogled-chromium")

INI_TEXT="\
[_metadata]\n\
publication_time = $PUB_TIME\n\
github_author = squalus\n\
note = Built at commit: https://github.com/Eloston/ungoogled-chromium/commit/$UGC_COMMIT\n\
\n\
[$PRODUCT_NAME]\n\
url = https://github.com/squalus/ungoogled-chromium-binaries/releases/download/$CHROMIUM_VERSION/$PRODUCT_NAME\n\
md5 = $MD5\n\
sha1 = $SHA1\n\
sha256 = $SHA256\n\
"
printf "$INI_TEXT" > "$PRODUCTS_DIR/$CHROMIUM_VERSION.ini"

echo "* Done"
