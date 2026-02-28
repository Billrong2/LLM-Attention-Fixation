#!/bin/bash
# $1 is a space-separated list
f() {
    sorted_lst=($(echo $1 | tr ' ' '\n' | sort -n))
    echo "${sorted_lst[@]:0:3}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "5 8 1 3 0") = "0 1 3" ]]
}

run_test
