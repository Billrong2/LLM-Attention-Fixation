#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
f() {
    new_text=$(echo $1 | sed "s/$2/$3/g")
    echo $new_text | tr '[:lower:]' '[:upper:]'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "zn kgd jw lnt" "h" "u") = "ZN KGD JW LNT" ]]
}

run_test
