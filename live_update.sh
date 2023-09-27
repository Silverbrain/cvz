#!/bin/zsh
fswatch -0 -r -E -e ".*" -i "\.{1}(tex|cls)$" --event Updated . | xargs -0 -n 1 ./test.sh