#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    local array=($1)
    local index=$2
    if (( index < 0 )); then
        index=$(( ${#array[@]} + index ))
    fi
    echo ${array[index]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1" "0") = "1" ]]
}

run_test
