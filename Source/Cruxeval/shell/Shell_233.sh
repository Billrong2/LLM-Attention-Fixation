#!/bin/bash
# $1 is a space-separated list
f() {
    local xs=($1)
    local length=${#xs[@]}
    
    for ((idx=$length-1; idx>=0; idx--)); do
        item=${xs[0]}
        xs=(${xs[@]:1})
        xs=(${xs[@]} $item)
    done
    
    echo "${xs[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3") = "1 2 3" ]]
}

run_test
