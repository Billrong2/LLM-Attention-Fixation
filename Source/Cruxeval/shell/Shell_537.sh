#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=($(echo $1 | sed 's/./& /g'))
    text[${#text[@]}]=$2
    length=${#text[@]}
    echo "["$length"]"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abv" "a") = "[4]" ]]
}

run_test
