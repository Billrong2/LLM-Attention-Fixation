#!/bin/bash
# $1 is a space-separated list
f() {
    local array=($1)
    while [[ "${array[@]}" =~ -1 ]]; do
        unset 'array[${#array[@]}-3]'
    done
    while [[ "${array[@]}" =~ 0 ]]; do
        unset 'array[${#array[@]}-1]'
    done
    while [[ "${array[@]}" =~ 1 ]]; do
        unset 'array[0]'
    done
    echo "${array[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0 2") = "" ]]
}

run_test
