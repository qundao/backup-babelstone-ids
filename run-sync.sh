#!/usr/bin/env bash
set -eu

TEMP_DIR="temp"
URL="https://www.babelstone.co.uk/CJK"

FILENAME="IDS.TXT"
PUA_FILENAME="IDS_PUA.TXT"
INDEX_FILE="readme.html"
README_FILE="README.md"

echo "Intall deps"
pip install markdownify

pushd $TEMP_DIR

echo "Downloading readme from $URL..."
curl -s -o "$INDEX_FILE" "$URL/IDS.HTML"
markdownify "$INDEX_FILE" > "$README_FILE"
sed -i "s|../index.html|$URL/index.html|g" "$README_FILE"

echo "Downloading file from $URL..."
curl -s -o "$FILENAME" "$URL/$FILENAME"
curl -s -o "$PUA_FILENAME" "$URL/$PUA_FILENAME"

# if [[ ! -f "$FILENAME" ]]; then
#     echo "NO $FILENAME"
#     exit 1
# fi

popd

echo "sync"
cp -rf "${TEMP_DIR}"/* ./
