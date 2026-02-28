#!/bin/bash
# $1 is a string
f() {
    text=$1
    even=""
    odd=""
    for ((i=0; i<${#text}; i++)); do
        if [ $((i % 2)) -eq 0 ]; then
            even+=${text:i:1}
        else
            odd+=${text:i:1}
        fi
    done
    echo $even${odd,,}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Mammoth") = "Mmohamt" ]]
}

run_test
