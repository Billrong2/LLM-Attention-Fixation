#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    array=($1)
    n=$2
    result=("${array[@]:n}")
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0 0 1 2 2 2 2" "4") = "2 2 2" ]]
}

run_test
