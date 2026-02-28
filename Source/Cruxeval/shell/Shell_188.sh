#!/bin/bash
# $1 is a space-separated list
f() {
    strings=($1)
    new_strings=()
    
    for string in "${strings[@]}"; do
        first_two=${string:0:2}
        if [[ $first_two == "a"* || $first_two == "p"* ]]; then
            new_strings+=($first_two)
        fi
    done
    
    echo "${new_strings[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a b car d") = "a" ]]
}

run_test
