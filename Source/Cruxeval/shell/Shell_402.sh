#!/bin/bash
# $1 is an integer
# $2 is a space-separated list
f() {
    n=$1
    l=($2)
    declare -A archive
    for ((i=0; i<n; i++)); do
        archive=()
        for x in "${l[@]}"; do
            archive[$((x + 10))]=$((x * 10))
        done
    done

    for key in "${!archive[@]}"; do
        echo "$key:${archive[$key]}"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0" "aaa bbb") = "" ]]
}

run_test
