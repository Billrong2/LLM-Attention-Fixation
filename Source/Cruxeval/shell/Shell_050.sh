#!/bin/bash
# $1 is a space-separated list
f() {
    local arr=($1)
    arr=()
    for ((i=0; i < ${#arr[@]}; i++)); do
        arr+=1
    done
    arr+=1
    echo "${arr[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a c v") = "1" ]]
}

run_test
