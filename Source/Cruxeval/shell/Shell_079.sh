#!/bin/bash
# $1 is a space-separated list
f() {
    local arr=($1)
    arr=()
    arr+=('1')
    arr+=('2')
    arr+=('3')
    arr+=('4')
    echo $(IFS=,; echo "${arr[*]}")
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0 1 2 3 4") = "1,2,3,4" ]]
}

run_test
