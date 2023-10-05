#!/bin/zsh
fswatch -0 -E -r -e ".*" -i "\\.(tex|cls)$" --event Updated . | xargs -0 -n 1 ./test.sh