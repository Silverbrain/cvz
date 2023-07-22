#!/bin/zsh
fswatch -0 -r -e ".*" -i "\\.tex$" --event Updated . | xargs -0 -n 1 ./test.sh