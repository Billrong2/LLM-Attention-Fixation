#!/bin/bash
# $1 is a space-separated list
f() {
    array=($1)
    n=${array[-1]}
    unset 'array[-1]'
    array=("${array[@]}" "$n" "$n")
    echo "${array[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 1 2 2") = "1 1 2 2 2" ]]
}

run_test
