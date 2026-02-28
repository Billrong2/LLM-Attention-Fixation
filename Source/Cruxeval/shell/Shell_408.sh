#!/bin/bash
# $1 is a list
f() {
    local -a array="($1)"  # Convert the string to an array
    local -a reversed=()

    for (( idx=${#array[@]}-1; idx>=0; idx-- )); do
        reversed+=("${array[idx]}")
    done

    echo "${reversed[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-4 6 0 4 -7 2 -1") = "-1 2 -7 4 0 6 -4" ]]
}

run_test
