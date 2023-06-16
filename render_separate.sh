#!/bin/zsh

# Directory of .tex files mentioned in the main.tex
TEX_FILE_DIR="sections"

# Auxiliary directory name
OUTPUT_DIR="aux"

########## FLAGS ##########
OPEN_FILES=false # Open pdf files after compilation
RENDER_PHOTO="\let\ifrenderphoto\iffalse" # Render photo at top left corner

## TESTING ##
RENDER_LOCATION="\let\ifrenderloc\iffalse" # Render location under the Name
#############

VERBOSE=false #

PRINT_LOG="> /dev/null" # Dump lualatex standard input if verbose is false

# Reading input options
while getopts ":vOR" opt; do
    case $opt in
        v) # Verboes
            VERBOSE=true
            PRINT_LOG=""
        ;;
        O) # Open files
            OPEN_FILES=true
        ;;
        R) # Render photo
            if $VERBOSE; then
                echo "Creating the resume with photo."
            fi
            RENDER_PHOTO="\let\ifrenderphoto\iftrue"
        ;;
        L) # Render location
            if $VERBOSE; then
                echo "Creating the resume with location."
            fi
            RENDER_LOCATION="\let\ifrenderloc\iftrue"
        ;;
        \?) # Bad argument
            echo "Invalide option -$OPTARG.\n"
            echo "Usage: $0 [-v] [-O] [-R]\n"
            echo "\t-v\n\t\tUsed to get more verbose status."
            echo "\t-O\n\t\tUsed to open pdf files after the latex compilation is done."
            echo "\t-R\n\t\tUsed to instruct the latex to render the photo at the begining of the resume."
            echo "\t-L\n\t\tUsed to instruct the latex to render the location (address) under the full name."
            exit 1
        ;;
    esac
done

# Checking if output directory exists
if [ -d "$OUTPUT_DIR" ]; then
    if $VERBOSE; then
        echo "output directory exists."
    fi
else
    if $VERBOSE; then
        echo "output directory does not exist.\nCreating the $OUTPUT_DIR directory."
    fi
    mkdir "$OUTPUT_DIR" # Creating output dir for aux files
fi

# Looping through tex files mentioned in main.tex
for TEX_FILE in "$TEX_FILE_DIR"/*.tex; do
    if [ -f "$TEX_FILE" ]; then # Check if the texfile exists

        # assembling lualatex command
        command="lualatex --output-directory=$OUTPUT_DIR \"$RENDER_PHOTO$RENDER_LOCATION\input{$TEX_FILE}\" $PRINT_LOG"
        eval "$command"
        

        ##########
        # Moving pdf files from output directory to the root
        # directory for easier access
        ##########
        mv "$OUTPUT_DIR"/*.pdf .
    else
        echo "No tex file was found in $TEX_FILE_DIR directory."
        return 0
    fi
done
##########
# Opening all pdf files in the root directory if -O flag is set
##########
if $OPEN_FILES; then
    for PDF_FILE in *.pdf; do
        open $PDF_FILE
    done
fi