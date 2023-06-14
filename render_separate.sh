#!/bin/zsh

TEX_FILE_DIR="sections"
OUTPUT_DIR="aux"

OPEN_FILES=false
RENDER_PHOTO="\let\ifrenderphoto\iffalse"

VERBOSE=false

while getopts ":vOR" opt; do
    case $opt in
        v)
            VERBOSE=true
        ;;
        O)
            OPEN_FILES=true
            # shift
        ;;
        R)
            if [ VERBOSE ]; then
                echo "Creating the resume with photo."
            fi
            RENDER_PHOTO="\let\ifrenderphoto\iftrue"
            # shift
        ;;
        \?)
            echo "Invalide option -$OPTARG.\n"
            echo "Usage: $0 [-v] [-O] [-R]\n"
            echo "\t-v\n\t\tUsed to get more verbose status."
            echo "\t-O\n\t\tUsed to open pdf files after the latex compilation is done."
            echo "\t-R\n\t\tUsed to instruct the latex to render the photo at the begining of the resume."
            exit 1
        ;;
    esac
done

if [ -d "$OUTPUT_DIR" ]; then
    if [ VERBOSE ]; then
        echo "output directory exists."
    fi
else
    if [ VERBOSE ]; then
        echo "output directory does not exist.\nCreating the $OUTPUT_DIR directory."
    fi
    mkdir "$OUTPUT_DIR"
fi

for TEX_FILE in "$TEX_FILE_DIR"/*.tex; do
    if [ -f "$TEX_FILE" ]; then
        lualatex --output-directory="$OUTPUT_DIR" "$RENDER_PHOTO\input{$TEX_FILE}"
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