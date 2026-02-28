#!/bin/bash
# $1 is a space-separated list
f() {
    local xs=($1)
    local new_x=$(( ${xs[0]} - 1 ))
    unset xs[0]
    xs=("${xs[@]}")
    
    while [ $new_x -le ${xs[0]} ]; do
        unset xs[0]
        xs=("${xs[@]}")
        new_x=$((new_x - 1))
    done
    
    xs=($new_x "${xs[@]}")
    echo "${xs[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "6 3 4 1 2 3 5") = "5 3 4 1 2 3 5" ]]
}

run_test
