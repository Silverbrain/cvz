#!/bin/zsh

TEX_FILE_DIR="sections"
OUTPUT_DIR="aux"

OPEN_FILES=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -O|--open-pdf)
            OPEN_FILES=true
            shift
        ;;
        *)
            echo "Invalide option.\n"
            echo "Usage: $0 [-O|--open-pdf]"
            exit 1
        ;;
    esac
done

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

if $OPEN_FILES; then
    for PDF_FILE in *.pdf; do
        open $PDF_FILE
    done
fi