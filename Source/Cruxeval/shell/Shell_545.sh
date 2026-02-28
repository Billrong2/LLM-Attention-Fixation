#!/bin/bash
# $1 is a space-separated list
f() {
    local array=($1)
    local result=()
    local index=0
    while [ $index -lt ${#array[@]} ]; do
        result+=(${array[-1]})
        unset 'array[${#array[@]}-1]'
        index=$((index + 2))
    done
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "8 8 -4 -9 2 8 -1 8") = "8 -1 8" ]]
}

run_test
