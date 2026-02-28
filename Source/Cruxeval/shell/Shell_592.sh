#!/bin/bash
# $1 is a space-separated list
f() {
    numbers=($1)
    new_numbers=()
    for (( i=${#numbers[@]}-1; i>=0; i-- )); do
        new_numbers+=(${numbers[i]})
    done
    echo "${new_numbers[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "11 3") = "3 11" ]]
}

run_test
