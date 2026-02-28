#!/bin/bash
# $1 is a newline-separated, space-separated list
f() {
    sorted_vecs=()
    while read -r line; do
        sorted_line=($(echo $line | tr ' ' '\n' | sort -n | tr '\n' ' '))
        sorted_vecs+=("${sorted_line[@]}")
    done <<< "$1"
    echo "${sorted_vecs[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
