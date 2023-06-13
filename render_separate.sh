#!/bin/zsh

TEX_FILE_DIR="sections"
OUTPUT_DIR="aux"

if [ -d "$OUTPUT_DIR" ]; then
    echo "The directory exists."
else
    echo "The directory does not exist.\nCreating the $OUTPUT_DIR directory."
    mkdir "$OUTPUT_DIR"
fi

for TEX_FILE in "$TEX_FILE_DIR"/*.tex; do
    if [ -f "$TEX_FILE" ]; then
        lualatex --output-directory="$OUTPUT_DIR" "$TEX_FILE"
        mv "$OUTPUT_DIR"/*.pdf .
    else
        echo "No tex file was found in $TEX_FILE_DIR directory."
        return 0
    fi
done