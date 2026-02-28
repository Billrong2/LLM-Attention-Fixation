#!/bin/bash
# $1 is a space-separated list
# $2 is a space-separated list
f() {
    local base_list=($1)
    local nums=($2)
    local res=("${base_list[@]}")
    
    for num in "${nums[@]}"; do
        res+=($num)
    done
    
    for (( i=-${#nums[@]}; i<0; i++ )); do
        res+=(${res[i]})
    done
    
    echo "${res[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "9 7 5 3 1" "2 4 6 8 0") = "9 7 5 3 1 2 4 6 8 0 2 6 0 6 6" ]]
}

run_test
