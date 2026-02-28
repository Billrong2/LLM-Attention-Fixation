#!/bin/bash
# $1 is a string
# $2 is a space-separated list
f() {
    string=$1
    numbers=($2)
    arr=()
    for num in "${numbers[@]}"; do
        arr+=($(printf "%0${num}d" $string))
    done
    echo "${arr[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "4327" "2 8 9 2 7 1") = "4327 00004327 000004327 4327 0004327 4327" ]]
}

run_test
