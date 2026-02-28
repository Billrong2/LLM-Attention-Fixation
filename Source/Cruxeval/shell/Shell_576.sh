#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    output=()
    output+=('x')
    array=($1)
    const=$2
    for (( i=1; i<=${#array[@]}; i++ )); do
        if (( i % 2 != 0 )); then
            output+=($(( ${array[i-1]} * -2 )))
        else
            output+=($const)
        fi
    done
    echo "${output[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3" "-1") = "x -2 -1 -6" ]]
}

run_test
