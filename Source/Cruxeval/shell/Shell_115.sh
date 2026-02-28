#!/bin/bash
# $1 is a string
f() {
    text=$1
    res=""
    for (( i=0; i<${#text}; i++ )); do
        ch=$(printf '%d' "'${text:$i:1}")
        if (( ch == 61 )); then
            break
        fi
        if (( ch != 0 )); then
            res="$res$ch; "
        fi
    done
    echo "b'$res'"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "os||agx5") = "b'111; 115; 124; 124; 97; 103; 120; 53; '" ]]
}

run_test
