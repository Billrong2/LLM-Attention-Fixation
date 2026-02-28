#!/bin/bash
# $1 is a space-separated list
f() {
    sorted_values=($(echo $1 | tr ' ' '\n' | sort -n))
    echo "${sorted_values[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 1 1 1") = "1 1 1 1" ]]
}

run_test
