#!/bin/zsh

updated_file=$(basename $1)
shift
OPEN_WITH="/Applications/Visual Studio Code.app"

# Directory of .tex files mentioned in the main.tex
TEX_FILE_DIR="sections"

# Auxiliary directory name
OUTPUT_DIR="aux"

OUTPUT_PREFIX=""

########## FLAGS ##########
OPEN_FILES=false # Open pdf files after compilation
RENDER_PHOTO="\let\ifrenderphoto\iffalse" # Render photo at top left corner

## TESTING ##
RENDER_LOCATION="\let\ifrenderloc\iffalse" # Render location under the Name
#############

VERBOSE=false #

PRINT_LOG="> /dev/null" # Dump lualatex standard input if verbose is false

# Reading input options
while [ $# -gt 0 ]; do
    case $1 in
        -v|--verbose) # Verboes
            VERBOSE=true
            PRINT_LOG=""
            shift
        ;;
        -O|--open-files) # Open files
            OPEN_FILES=true
            shift
        ;;
        -R|--render-photo) # Render photo
            if $VERBOSE; then
                echo "Creating the resume with photo."
            fi
            RENDER_PHOTO="\let\ifrenderphoto\iftrue"
            shift
        ;;
        -L|--render-location) # Render location
            if $VERBOSE; then
                echo "Creating the resume with location."
            fi
            RENDER_LOCATION="\let\ifrenderloc\iftrue"
            shift
        ;;
        -o|--output-prefix)
            OUTPUT_PREFIX=$2
            shift 2
        ;;
        *) # Bad argument
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

current_time=$(date +%H:%M:%S)

echo -n -e "\e[36m$current_time\e[0m    $updated_file \e[33mUPDATED\e[0m    Rendering in progress"

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
        output=$(eval "$command")
        if [[ -n "$output" ]]; then
            echo -e "\e[97;41mERROR\e[0m"
            echo "$output"
            exit 1
        fi
    else
        echo "No tex file was found in $TEX_FILE_DIR directory."
        return 0
    fi
done

##########
# Moving pdf files from output directory to the root
# directory for easier access
##########
for PDF_FILE in "$OUTPUT_DIR"/*.pdf; do
    if [ -f "$PDF_FILE" ]; then
        
        # Adding prefix to the name of pdf files in case it's specified
        if [[ -n "$OUTPUT_PREFIX" ]]; then
            # Extract the filename and extension
            filename=$(basename -- "$PDF_FILE")
            extension="${filename##*.}"
            filename="${filename%.*}"
            
            # Create the new filename with the prefix
            new_filename="${OUTPUT_PREFIX}_${filename}.${extension}"

            mv "$PDF_FILE" ./"$new_filename"
            
            PDF_FILE=./"$new_filename"
        fi

        # Opening all pdf files in the root directory if -O flag is set
        if $OPEN_FILES; then
            sleep 1
            open -a "$OPEN_WITH" $new_filename
        fi
    fi
    
done

echo " ==> \e[42mSUCCESS\e[0m"