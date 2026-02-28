#!/bin/bash
# $1 is an integer
# $2 is an integer
# $3 is an integer
f() {
    sorted_nums=$(echo "$1 $2 $3" | tr ' ' '\n' | sort -n | tr '\n' ',')
    echo "${sorted_nums%,}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "6" "8" "8") = "6,8,8" ]]
}

run_test
