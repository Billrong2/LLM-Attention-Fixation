#!/bin/bash
# $1 is a space-separated list
f() {
    input_array=($1)
    result=()

    for ((i=${#input_array[@]} - 1; i >= 0; i--)); do
        result+=($(( ${input_array[i]} * 2 )))
    done

    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3 4 5") = "10 8 6 4 2" ]]
}

run_test
