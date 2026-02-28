#!/bin/bash
# $1 is a string
f() {
    text=$1
    for space in $text; do
        if [ $space = ' ' ]; then
            text=$(echo $text | sed 's/^[[:space:]]*//')
        else
            text=$(echo $text | sed "s/cd/$space/")
        fi
    done
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "lorem ipsum") = "lorem ipsum" ]]
}

run_test
