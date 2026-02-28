#!/bin/bash
# $1 is a space-separated list
f() {
    IFS=',' read -r -a array <<< "$1"
    IFS=$'\n' sorted=($(sort -n <<<"${array[*]}"))
    reversed=()
    for (( idx=${#sorted[@]}-1 ; idx>=0 ; idx-- )) ; do
        reversed+=("${sorted[idx]}")
    done
    echo "${reversed[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "6 4 2 8 15") = "6 4 2 8 15" ]]
}

run_test
