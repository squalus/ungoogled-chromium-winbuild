#!/usr/bin/env bash

STRIP_NONDETERM=$(which strip-nondeterminism)
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PRODUCTS_DIR="$DIR"/products
rm -rf "$PRODUCTS_DIR"
mkdir -p "$PRODUCTS_DIR"
TEMP_DIR="$DIR"/temp
PRODUCT_NAME=$(basename "$TEMP_DIR"/ungoogled-chromium_*.zip)
echo "* Product: $PRODUCT_NAME"
mv "$TEMP_DIR"/"$PRODUCT_NAME" "$PRODUCTS_DIR"
mv "$TEMP_DIR"/build.txt "$PRODUCTS_DIR"
rm -rf "$TEMP_DIR"
cd "$PRODUCTS_DIR"

if [ -x "$STRIP_NONDETERM" ]; then
    echo "* Running strip-nondeterminism"
    "$STRIP_NONDETERM" "$PRODUCTS_DIR"/"$PRODUCT_NAME"
else
    echo "* Skipping strip-nondeterminism, binary not found"
fi

echo "* Done"
