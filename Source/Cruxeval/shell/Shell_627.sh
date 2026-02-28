#!/bin/bash
# $1 is a newline-separated, space-separated list
f() {
    declare -A dict
    while IFS=' ' read -r key value; do
        dict["$key"]=$value
    done <<< "$1"
    
    result=()
    for value in "${dict[@]}"; do
        result+=("$value")
    done
    
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "u 1
s 7
u -5") = "-5 7" ]]
}

run_test
