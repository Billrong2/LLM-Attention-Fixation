#!/bin/bash
# $1 is a space-separated list
f() {
    read -a array <<< "$1"
    new_array=("${array[@]}")
    new_array=($(echo "${new_array[@]}" | tr ' ' '\n' | tac | tr '\n' ' '))
    result=()
    for x in "${new_array[@]}"; do
        result+=($((x * x)))
    done
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 1") = "1 4 1" ]]
}

run_test
