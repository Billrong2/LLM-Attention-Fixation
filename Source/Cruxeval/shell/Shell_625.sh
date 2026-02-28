#!/bin/bash
# $1 is a string
f() {
    local text="$1"
    local count=0
    for (( i=0; i<${#text}; i++ )); do
        char="${text:$i:1}"
        if [[ $char == [".?!.,"] ]]; then
            ((count++))
        fi
    done
    echo "$count"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "bwiajegrwjd??djoda,?") = "4" ]]
}

run_test
