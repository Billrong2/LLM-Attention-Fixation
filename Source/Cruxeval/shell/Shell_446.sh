#!/bin/bash
# $1 is a space-separated list
f() {
    array=($1)
    l=${#array[@]}
    if [ $(($l % 2)) -eq 0 ]; then
        array=()
    else
        array=($(echo "${array[@]}" | tr ' ' '\n' | tac))
    fi
    echo "${array[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
