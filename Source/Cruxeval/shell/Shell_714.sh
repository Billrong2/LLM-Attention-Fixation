#!/bin/bash
# $1 is a space-separated list
f() {
    array=($1)
    array=($(echo "${array[@]}" | rev))
    array=()
    for ((i=0; i<${#array[@]}; i++)); do
        array+=("x")
    done
    array=($(echo "${array[@]}" | rev))
    echo "${array[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "3 -2 0") = "" ]]
}

run_test
